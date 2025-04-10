import 'package:fudiee/models/printer/printer.model.dart';
import 'package:fudiee/models/product/product_item.model.dart';
import 'package:fudiee/screens/printer/printer.screen.dart';
import 'package:fudiee/widgets/progress_indicator.widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudiee/main.data.dart';
import 'package:fudiee/models/place/place.model.dart';
import 'package:fudiee/models/receipt/active_receipt.model.dart';
import 'package:fudiee/models/receipt/receipt.model.dart';
import 'package:fudiee/routes/router.dart';
import 'package:fudiee/screens/receipt/receipts.screen.dart';
import 'package:fudiee/themes/app_colors.dart';
import 'package:fudiee/widgets/buttons/receipt_action_button.widget.dart';
import 'package:fudiee/widgets/places.widget.dart';
import 'package:fudiee/widgets/payment_method_toggle.widget.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fudiee/widgets/products.widget.dart';

class ReceiptScreen extends ConsumerStatefulWidget {
  const ReceiptScreen({super.key});
  static String routePath = '/receipt';
  static String name = 'ReceiptScreen';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends ConsumerState<ReceiptScreen> {
  final PlaceController placeController = PlaceController();
  final PaymentMethodController paymentMethodController =
      PaymentMethodController();
  bool _isPrinting = false;

  void _onSavePressed(Receipt receipt) async {
    debugPrint('onPressed->save_receipt');
    await _onSave(receipt);
  }

  Future<void> _requestBluetoothPermission() async {
    if (await Permission.bluetoothConnect.request().isGranted) {
      debugPrint("Bluetooth CONNECT permission granted");
    } else {
      debugPrint("Bluetooth CONNECT permission denied");
    }
  }

  Future<void> _requestBluetoothScanPermission() async {
    if (await Permission.bluetoothScan.request().isGranted) {
      debugPrint("Bluetooth SCAN permission granted");
    } else {
      debugPrint("Bluetooth SCAN permission denied");
    }
  }

  Future<void> _requestPermissions() async {
    await _requestBluetoothPermission();
    await _requestBluetoothScanPermission();
  }

  Future<void> _onSave(Receipt receipt, {String status = 'OPEN'}) async {
    final placeId = placeController.value?.id;
    final placeName = placeController.value?.name;
    final price = receipt.getTotal();

    if (receipt.productItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Додайте хоча б один товар'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final updatedReceipt = receipt.copyWith(
      paymentMethod: paymentMethodController.value,
      status: status,
      place: placeId,
      price: price,
      placeName: placeName,
    );
    try {
      await ref.receipts.save(updatedReceipt);
      _goToReceipts();
    } catch (e) {
      debugPrint('Error saving receipt: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Помилка збереження чека: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _onClosePressed(Receipt receipt) {
    debugPrint('onPressed->close_receipt');
    _onSave(receipt, status: 'CLOSED');
  }

  void _goToReceipts() {
    final router = ref.read(appRouterProvider);
    ref.receipts.triggerNotify();
    router.goNamed(ReceiptsScreen.name);
  }

  _handlePrintReceiptSplited(Printer printer, Receipt receipt) async {
    // Group product items by root category
    final groupedItems =
        receipt.productItems.groupBy((ProductItem item) => item.rootCategory);

    final categoriesCount = groupedItems.keys.length;
    if (categoriesCount < 2) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          return const ProgressIndicatorWidget();
        },
      );
      await printer.print(receipt);
      _checkMountedAndPopDialog();
      return;
    }

    // Print first category automatically
    final categories = groupedItems.keys.toList();
    final firstCategory = categories[0];
    final firstItems = groupedItems[firstCategory]!;
    final firstSplittedReceipt = receipt.copyWith(productItems: firstItems);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return const ProgressIndicatorWidget();
      },
    );
    await printer.print(firstSplittedReceipt);
    _checkMountedAndPopDialog();

    // Track printed categories
    final printedCategories = <String>{firstCategory};
    int currentIndex = 1;

    // Show dialog for remaining categories
    while (currentIndex < categories.length) {
      if (!mounted) return;
      final result = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Друк чеків'),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                children: categories.map((category) {
                  return ListTile(
                    leading: Icon(
                      printedCategories.contains(category)
                          ? Icons.check_circle
                          : Icons.circle_outlined,
                      color: printedCategories.contains(category)
                          ? Colors.green
                          : Colors.grey,
                    ),
                    title: Text(category),
                  );
                }).toList(),
              ),
            ),
            actions: [
              TextButton.icon(
                icon: const Icon(Icons.cancel),
                label: const Text('Відміна'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton.icon(
                icon: const Icon(Icons.print),
                label: const Text('Продовжити'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        },
      );

      if (result != true) break;

      final currentCategory = categories[currentIndex];
      final items = groupedItems[currentCategory]!;
      final splittedReceipt = receipt.copyWith(productItems: items);
      if (!mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          return const ProgressIndicatorWidget();
        },
      );
      await printer.print(splittedReceipt);

      printedCategories.add(currentCategory);
      currentIndex++;
    }
  }

  void _checkMountedAndPopDialog() {
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future<void> _handlePrinting(String printerAddress, Receipt receipt) async {
    debugPrint('Printer address: $printerAddress');

    // Show progress dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return const ProgressIndicatorWidget();
      },
    );

    final printer = ref.read(printerProvider.notifier);
    try {
      await printer.connect(printerAddress);
    } catch (e) {
      _checkMountedAndPopDialog();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Не можу підключитись до принтера'),
          backgroundColor: Colors.red,
        ),
      );
      debugPrint('Error connecting printer: $e');
      return;
    }
    _checkMountedAndPopDialog();
    await _handlePrintReceiptSplited(printer, receipt);
    try {
      await printer.disconnect();
    } catch (e) {
      debugPrint('Error disconnecting printer: $e');
    }

    if (!mounted) return;
    _checkMountedAndPopDialog();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Друк завершено'),
        backgroundColor: Colors.green,
      ),
    );
    debugPrint('Receipt printed successfully');
  }

  void _onPrintPressed(Receipt receipt) async {
    if (_isPrinting) return;

    setState(() => _isPrinting = true);

    try {
      await _requestPermissions();
      final printerAddress = await ref.read(printerProvider.future);

      if (!mounted) return;

      if (printerAddress.isNotEmpty) {
        await _handlePrinting(printerAddress, receipt);
      } else {
        debugPrint('No printer address found');
        final router = ref.read(appRouterProvider);
        router.push(PrinterScreen.routePath);
      }
    } catch (e) {
      _handlePrintError(e);
    } finally {
      if (mounted) {
        setState(() => _isPrinting = false);
      }
    }
  }

  void _handlePrintError(Object e) {
    debugPrint('Error printing receipt: $e');
    if (mounted) {
      // Make sure to pop the dialog if it's showing
      try {
        Navigator.of(context).pop();
      } catch (_) {}

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Помилка друку: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeReceipt = ref.watch(activeReceiptProvider);
    final receiptTotal = activeReceipt?.getTotal() ?? 0;
    paymentMethodController.value = activeReceipt?.paymentMethod ?? 'CASH';
    placeController.value = activeReceipt?.place != null
        ? Place(id: activeReceipt!.place, name: activeReceipt.placeName ?? '')
        : null;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: scaffoldBgColor,
        title: Center(
          child: Text(
            'Чек',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha((0.2 * 255).toInt()),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Сума: $receiptTotal грн',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: primaryTextColor,
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Expanded(
                  child: ReceiptActionButtonWidget(
                    onPressed: _goToReceipts,
                    backgroundColor: Colors.red,
                    text: 'На головну',
                    icon: Icons.arrow_back,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: ReceiptActionButtonWidget(
                    onPressed: () => _onSavePressed(activeReceipt!),
                    backgroundColor: Colors.blue,
                    text: 'Зберегти',
                    icon: Icons.save,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: ReceiptActionButtonWidget(
                    onPressed: () => _onPrintPressed(activeReceipt!),
                    backgroundColor: Colors.orange,
                    text: 'Друкувати',
                    icon: Icons.print,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: ReceiptActionButtonWidget(
                    onPressed: () => _onClosePressed(activeReceipt!),
                    backgroundColor: Colors.green,
                    text: 'Закрити',
                    icon: Icons.check,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PlacesWidget(controller: placeController),
                PaymentMethodToggle(controller: paymentMethodController),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: ProductsWidget(
                  useReceipt: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension<T> on List<T> {
  Map<String, List<T>> groupBy(String Function(T) key) {
    return fold(<String, List<T>>{}, (Map<String, List<T>> map, T element) {
      final String groupKey = key(element);
      map.putIfAbsent(groupKey, () => []);
      map[groupKey]!.add(element);
      return map;
    });
  }
}
