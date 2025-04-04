import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudiee/models/receipt/active_receipt.model.dart';
import 'package:fudiee/routes/router.dart';
import 'package:fudiee/screens/home/views/home/components/header_section.dart';
import 'package:fudiee/screens/receipt/receipt.screen.dart';
import 'package:fudiee/themes/app_colors.dart';
import 'package:fudiee/widgets/categories.widget.dart';
import 'package:fudiee/widgets/products.widget.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});
  static String routePath = '/cart';
  static String name = 'CartScreen';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final activeReceipt = ref.watch(activeReceiptProvider);
    final receiptTotal = activeReceipt?.getTotal() ?? 0;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: scaffoldBgColor,
        title: Center(
          child: Text(
            'Замовлення',
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Сума: $receiptTotal₴',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Flexible(
              child: ElevatedButton(
                onPressed: () {
                  debugPrint('onPressed->toReceipt');
                  final router = ref.read(appRouterProvider);
                  router.pushNamed(ReceiptScreen.name);
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'До Чеку',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              HeaderSection(
                onPressed: () {},
                title: 'Категорії',
              ),

              // categories section
              SizedBox(
                height: 115, // Fixed height for categories
                child: CategoriesWidget(),
              ),

              const SizedBox(
                height: 20,
              ),
              HeaderSection(
                onPressed: () {},
                title: 'Продукти',
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: ProductsWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
