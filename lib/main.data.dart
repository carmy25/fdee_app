

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: directives_ordering, top_level_function_literal_block, depend_on_referenced_packages

import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fudiee/models/category/category.model.dart';
import 'package:fudiee/models/place/place.model.dart';
import 'package:fudiee/models/product/product_item.model.dart';
import 'package:fudiee/models/product/product.model.dart';
import 'package:fudiee/models/receipt/receipt.model.dart';
import 'package:fudiee/models/user/user.model.dart';

final adapterProvidersMap = <String, Provider<Adapter<DataModelMixin>>>{
  'categories': categoriesAdapterProvider,
'places': placesAdapterProvider,
'productItems': productItemsAdapterProvider,
'products': productsAdapterProvider,
'receipts': receiptsAdapterProvider,
'users': usersAdapterProvider
};

extension AdapterWidgetRefX on WidgetRef {
  Adapter<Category> get categories => watch(categoriesAdapterProvider)..internalWatch = watch;
  Adapter<Place> get places => watch(placesAdapterProvider)..internalWatch = watch;
  Adapter<ProductItem> get productItems => watch(productItemsAdapterProvider)..internalWatch = watch;
  Adapter<Product> get products => watch(productsAdapterProvider)..internalWatch = watch;
  Adapter<Receipt> get receipts => watch(receiptsAdapterProvider)..internalWatch = watch;
  Adapter<User> get users => watch(usersAdapterProvider)..internalWatch = watch;
}

extension AdapterRefX on Ref {

  Adapter<Category> get categories => watch(categoriesAdapterProvider)..internalWatch = watch as Watcher;
  Adapter<Place> get places => watch(placesAdapterProvider)..internalWatch = watch as Watcher;
  Adapter<ProductItem> get productItems => watch(productItemsAdapterProvider)..internalWatch = watch as Watcher;
  Adapter<Product> get products => watch(productsAdapterProvider)..internalWatch = watch as Watcher;
  Adapter<Receipt> get receipts => watch(receiptsAdapterProvider)..internalWatch = watch as Watcher;
  Adapter<User> get users => watch(usersAdapterProvider)..internalWatch = watch as Watcher;
}