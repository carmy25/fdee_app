import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudiee/models/receipt/active_receipt.model.dart';
import 'package:fudiee/routes/router.dart';
import 'package:fudiee/screens/receipt/receipts.screen.dart';
import 'package:fudiee/themes/app_colors.dart';
import 'package:fudiee/widgets/places.widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'package:fudiee/widgets/products.widget.dart';

class ReceiptScreen extends ConsumerWidget {
  const ReceiptScreen({super.key});
  static String routePath = '/receipt';
  static String name = 'ReceiptScreen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeReceipt = ref.watch(activeReceiptProvider);
    final receiptTotal = activeReceipt?.getTotal() ?? 0;
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
                ElevatedButton.icon(
                  onPressed: () {
                    debugPrint('onPressed->reject');
                    final router = ref.read(appRouterProvider);
                    router.goNamed(ReceiptsScreen.name);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.arrow_back,
                      color: Colors.white, size: 30),
                  label: const Text(
                    'На головну',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    debugPrint('onPressed->toReceipts');
                    final router = ref.read(appRouterProvider);
                    router.goNamed(ReceiptsScreen.name);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.save, color: Colors.white, size: 30),
                  label: const Text(
                    'Зберегти',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    debugPrint('onPressed->toReceipts');
                    final router = ref.read(appRouterProvider);
                    router.goNamed(ReceiptsScreen.name);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.check, color: Colors.white, size: 30),
                  label: const Text(
                    'Закрити',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
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
                PlacesWidget(),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8.0),
                  child: ToggleSwitch(
                    minWidth: 120.0,
                    minHeight: 60.0,
                    cornerRadius: 20.0,
                    activeBgColor: [Colors.green],
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    labels: const ['Карта', 'Готівка'],
                    icons: const [Icons.credit_card, Icons.attach_money],
                    initialLabelIndex: 0,
                    onToggle: (index) {
                      debugPrint('switched to: $index');
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: ProductsWidget(products: []),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
