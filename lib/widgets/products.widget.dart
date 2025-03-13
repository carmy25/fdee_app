import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudiee/main.data.dart';
import 'package:fudiee/models/category/active_category.model.dart';
import 'package:fudiee/models/product/product.model.dart';
import 'package:fudiee/widgets/product_item.widget.dart';
import 'package:fudiee/widgets/progress_indicator.widget.dart';

class ProductsWidget extends ConsumerWidget {
  const ProductsWidget({super.key, required this.products});
  final List<Product> products;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      separatorBuilder: (_, __) => const SizedBox(
        height: 10,
      ),
      physics: const NeverScrollableScrollPhysics(),
      restorationId: 'cart_view',
      shrinkWrap: true,
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductItemWidget(
          product: product,
          canDelete: false,
        );
      },
    );
  }
}
