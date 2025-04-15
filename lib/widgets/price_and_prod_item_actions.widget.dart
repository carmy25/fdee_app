import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudiee/models/product/product.model.dart';
import 'package:fudiee/models/receipt/active_receipt.model.dart';
import 'package:fudiee/screens/home/views/cart/components/cartitem/components/cart_action_buttons.dart';
import 'package:fudiee/themes/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PriceAndProdItemActionsWidget extends ConsumerWidget {
  const PriceAndProdItemActionsWidget({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeReceipt = ref.watch(activeReceiptProvider);
    final activeReceiptNotifier = ref.read(activeReceiptProvider.notifier);
    if (activeReceipt == null) {
      return const Center(
        child: Text('No active receipt'),
      );
    }
    debugPrint('PriceAndProdItemActionsWidget.build: ${activeReceipt.id}');
    debugPrint(
        'activeReceiptNotifier.getProductItemAmount(${product.name}): ${activeReceiptNotifier.getProductItemAmount(product)}');
    final itemCount = activeReceiptNotifier.getProductItemAmount(product);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 10,
            ),
            Text(
              '₴${product.price}',
              style: TextStyle(
                fontSize: 23.sp,
                color: pinkColor,
              ),
            ),
            CartActionButtons(
              itemCount: itemCount,
              onAdd: () {
                debugPrint('onAdd');
                activeReceiptNotifier.updateProduct(
                    product, (item) => item.amount + 1);
              },
              onReduce: () {
                debugPrint('onReduce');
                if (itemCount == 0) {
                  return;
                }
                activeReceiptNotifier.updateProduct(
                    product, (item) => item.amount >= 0 ? item.amount - 1 : 0);
              },
            ),
          ],
        ),
      ],
    );
  }
}
