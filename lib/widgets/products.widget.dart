import 'package:flutter/material.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudiee/main.data.dart';
import 'package:fudiee/models/category/active_category.model.dart';
import 'package:fudiee/models/product/product.model.dart';
import 'package:fudiee/models/receipt/active_receipt.model.dart';
import 'package:fudiee/widgets/product_item.widget.dart';
import 'package:fudiee/widgets/progress_indicator.widget.dart';

class ProductsWidget extends ConsumerWidget {
  const ProductsWidget({super.key, this.useReceipt = false});
  final bool useReceipt;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Product> products = [];
    if (useReceipt) {
      final activeReceipt = ref.watch(activeReceiptProvider);
      if (activeReceipt == null) {
        return const Center(
          child: Text('No active receipt'),
        );
      }
      for (final prodItem in activeReceipt.productItems) {
        products.add(Product(
            categoryObject: BelongsTo(null),
            id: prodItem.productId,
            rootCategory: prodItem.rootCategory,
            name: prodItem.name,
            price: prodItem.price,
            category: '',
            image: prodItem.image));
      }
    } else {
      final activeCategory = ref.watch(activeCategoryProvider);

      if (activeCategory == null) {
        return ProgressIndicatorWidget();
      }
      debugPrint('activeCategory: $activeCategory');
      final state = ref.categories.watchOne(activeCategory, remote: true);
      if (state.isLoading) {
        return ProgressIndicatorWidget();
      }
      products.insertAll(0, state.model?.products?.toList() ?? []);
    }

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
