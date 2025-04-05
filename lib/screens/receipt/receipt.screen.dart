import 'package:fudiee/screens/printer/printer.screen.dart';
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

  Future<void> _onSave(Receipt receipt, {String status = 'OPEN'}) async {
    final placeId = placeController.value?.id;
    final placeName = placeController.value?.name;
    final price = receipt.getTotal();

    final updatedReceipt = receipt.copyWith(
      paymentMethod: paymentMethodController.value,
      status: status,
      place: placeId,
      price: price,
      placeName: placeName,
    );
    try {
      await ref.receipts.save(
        updatedReceipt,
      );
    } catch (e) {
      debugPrint('Error saving receipt: $e');
      rethrow;
    }
    _goToReceipts();
  }

  void _onClosePressed(Receipt receipt) {
    debugPrint('onPressed->close_receipt');
    _onSave(receipt, status: 'CLOSED');
  }

  void _goToReceipts() {
    final router = ref.read(appRouterProvider);
    router.goNamed(ReceiptsScreen.name);
  }

  void _onPrintPressed(Receipt receipt) async {
    debugPrint('onPressed->print_receipt');
    final router = ref.read(appRouterProvider);
    await _requestBluetoothPermission();
    await _requestBluetoothScanPermission();
    router.goNamed(PrinterScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    ref.invalidate(receiptsAdapterProvider);
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ReceiptActionButtonWidget(
                    onPressed: _goToReceipts,
                    backgroundColor: Colors.red,
                    text: 'На головну',
                    icon: Icons.arrow_back,
                  ),
                  SizedBox(width: 8.w),
                  ReceiptActionButtonWidget(
                    onPressed: () => _onSavePressed(activeReceipt!),
                    backgroundColor: Colors.blue,
                    text: 'Зберегти',
                    icon: Icons.save,
                  ),
                  SizedBox(width: 8.w),
                  ReceiptActionButtonWidget(
                    onPressed: () => _onPrintPressed(activeReceipt!),
                    backgroundColor: Colors.orange,
                    text: 'Друкувати',
                    icon: Icons.print,
                  ),
                  SizedBox(width: 8.w),
                  ReceiptActionButtonWidget(
                    onPressed: () => _onClosePressed(activeReceipt!),
                    backgroundColor: Colors.green,
                    text: 'Закрити',
                    icon: Icons.check,
                  ),
                ],
              ),
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
