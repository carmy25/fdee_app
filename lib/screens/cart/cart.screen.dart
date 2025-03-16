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
              'Сума: $receiptTotal грн',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            ElevatedButton(
              onPressed: () {
                debugPrint('onPressed->toReceipt');
                final router = ref.read(appRouterProvider);
                router.pushNamed(ReceiptScreen.name);
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 45),
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
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: Container(
      //   height: 50,
      //   margin: const EdgeInsets.all(10),
      //   child: ElevatedButton(
      //     onPressed: () {},
      //     child: const Center(
      //       child: Text('Hellosss'),
      //     ),
      //   ),
      // ),
      // bottomNavigationBar: BottomAppBar(
      //   color: Colors.amber,
      //   child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //       children: <Widget>[
      //         Row(children: [
      //           FloatingActionButton.extended(
      //             heroTag: UniqueKey(),
      //             onPressed: () {},
      //             label: Text('Зберегти'),
      //             icon: Icon(Icons.save),
      //           ),
      //           SizedBox(
      //             width: 12,
      //           ),
      //           FloatingActionButton.extended(
      //             heroTag: UniqueKey(),
      //             onPressed: () {},
      //             label: Text('Відхилити'),
      //             icon: Icon(Icons.cancel),
      //           ),
      //           DropdownButton<String>(
      //             value: 'Оплата Готівкою',
      //             icon: const Icon(Icons.arrow_downward),
      //             elevation: 16,
      //             style: const TextStyle(color: Colors.deepPurple),
      //             underline: Container(
      //               height: 2,
      //               color: Colors.deepPurpleAccent,
      //             ),
      //             onChanged: (String? value) {
      //               // This is called when the user selects an item.
      //             },
      //             items: [
      //               DropdownMenuItem<String>(
      //                 value: 'Оплата Готівкою',
      //                 child: Text('Оплата Готівкою'),
      //               ),
      //               DropdownMenuItem<String>(
      //                 value: 'Оплата Карткою',
      //                 child: Text('Оплата Карткою'),
      //               ),
      //             ],
      //           )
      //         ])
      //       ]),
      // ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          HeaderSection(
            onPressed: () {},
            title: 'Категорії',
          ),

          // categories section
          SizedBox(
            height: 115,
            child: CategoriesWidget(),
          ),

          const SizedBox(
            height: 20,
          ),
          HeaderSection(
            onPressed: () {},
            title: 'Продукти',
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: ProductsWidget(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
