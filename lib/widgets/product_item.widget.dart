import 'package:flutter/material.dart';
import 'package:fudiee/models/product/product.model.dart';
import 'package:fudiee/models/receipt/active_receipt.model.dart';
import 'package:fudiee/screens/home/views/cart/components/cartitem/components/build_image.dart';
import 'package:fudiee/widgets/price_and_prod_item_actions.widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductItemWidget extends ConsumerWidget {
  const ProductItemWidget(
      {super.key, required this.product, this.canDelete = true});

  final Product product;
  final bool canDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeReceipt = ref.watch(activeReceiptProvider);
    if (activeReceipt == null) {
      return const Center(
        child: Text('No active receipt'),
      );
    }
    final productAmount =
        ref.read(activeReceiptProvider.notifier).getProductItemAmount(product);
    final productTotal = product.price * productAmount;
    return Column(
      children: [
        Row(
          children: [
            BuildImage(image: product.image ?? 'assets/images/cake1.png'),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      child: Text(
                    product.name,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge,
                  )),
                ],
              ),
            ),
            if (canDelete)
              IconButton(
                icon: const Icon(Icons.close),
                tooltip: 'Видалити',
                onPressed: () {},
              ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PriceAndProdItemActionsWidget(
              product: product,
            ),
            Text(
              '₴$productTotal',
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        )
      ],
    );
  }
}
/*
BuildImage(image: image),
        const SizedBox(height: 10),
        SmoothIndicator(
          offset: index.toDouble(),
          count: 4,
          effect: const WormEffect(
            activeDotColor: Colors.pink,
            spacing: 12,
          ),
          size: const Size(8, 8),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              BuildPriceAndCartActions(
                price: price,
                index: index,
              ),
              SizedBox(height: 34.h),
              BuildDescriptionsAndRatings(
                title: title,
                desc: desc,
                rating: rating,
                index: index,
              ),
              SizedBox(height: 25.h),
              const AddYourMeal(),
              SizedBox(height: 35.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  minimumSize: const Size(double.infinity, 60),
                ),
                onPressed: () {},
                child: const Text(
                  'Place Order',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              SizedBox(height: 12.h),
            ],
          ),
        ),
*/
