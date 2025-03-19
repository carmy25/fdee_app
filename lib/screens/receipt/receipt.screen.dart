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

  Future<void> _onSave(Receipt receipt, {String status = 'OPEN'}) async {
    final updatedReceipt = receipt.copyWith(
      placeName: placeController.value?.name,
      place: placeController.value?.id ?? 0,
      paymentMethod: paymentMethodController.value,
      status: status,
    );
    try {
      await ref.receipts.save(updatedReceipt);
    } catch (e) {
      debugPrint('Error saving receipt: $e');
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
        padding: const EdgeInsets.all(10),
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
            // Placing "Сума: грн" above the buttons
            Text(
              'Сума: $receiptTotal грн',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: primaryTextColor,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReceiptActionButtonWidget(
                    onPressed: _goToReceipts,
                    backgroundColor: Colors.red,
                    text: 'На головну',
                    icon: Icons.arrow_back),
                ReceiptActionButtonWidget(
                    onPressed: () => _onSavePressed(activeReceipt!),
                    backgroundColor: Colors.blue,
                    text: 'Зберегти',
                    icon: Icons.save),
                ReceiptActionButtonWidget(
                    onPressed: () => _onClosePressed(activeReceipt!),
                    backgroundColor: Colors.green,
                    text: 'Закрити',
                    icon: Icons.check),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
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
