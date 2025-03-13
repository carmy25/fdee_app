import 'package:flutter/material.dart';
import 'package:fudiee/models/product/product.model.dart';
import 'package:fudiee/models/product/product_item.model.dart';
import 'package:fudiee/models/receipt/receipt.model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'active_receipt.model.g.dart';

typedef IntCallback<T> = int Function(T item);

@Riverpod(keepAlive: true)
class ActiveReceipt extends _$ActiveReceipt {
  @override
  Receipt? build() {
    debugPrint('ActiveReceipt.build');
    return null;
  }

  setActive(Receipt receipt) {
    debugPrint('setActiveRecept: $receipt');
    state = receipt;
  }

  updateProduct(Product product, IntCallback<ProductItem> callback) {
    final receipt = state;
    if (receipt == null) {
      return;
    }
    final newReceipt = receipt.copyWith(productItems: []);
    final items = receipt.productItems.toList();
    var alreadyAdded = false;
    for (final item in items) {
      if (item.productId != product.id) {
        newReceipt.productItems.add(item);
        continue;
      }
      newReceipt.productItems.add(
        ProductItem(
          name: item.name,
          amount: callback(item),
          price: product.price,
          image: product.image,
          productId: item.productId,
          receiptId: newReceipt.id,
        ),
      );
      alreadyAdded = true;
    }
    if (alreadyAdded) {
      state = newReceipt;
      return;
    }
    newReceipt.productItems.add(
      ProductItem(
        name: product.name,
        amount: 1,
        price: product.price,
        image: product.image,
        productId: product.id,
        receiptId: newReceipt.id,
      ),
    );
    state = newReceipt;
    debugPrint(wrapWidth: 1024, 'updateProduct: $state');
  }

  int getProductItemAmount(Product product) {
    final receipt = state;
    if (receipt == null) {
      return 0;
    }
    for (final item in receipt.productItems.toList()) {
      if (item.productId == product.id) {
        return item.amount;
      }
    }
    return 0;
  }
}
