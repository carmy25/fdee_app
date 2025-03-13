

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: directives_ordering, top_level_function_literal_block, depend_on_referenced_packages

import 'package:flutter_data/flutter_data.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fudiee/models/category/category.model.dart';
import 'package:fudiee/models/place/place.model.dart';
import 'package:fudiee/models/product/product.model.dart';
import 'package:fudiee/models/receipt/receipt.model.dart';
import 'package:fudiee/models/user/user.model.dart';

// ignore: prefer_function_declarations_over_variables
ConfigureRepositoryLocalStorage configureRepositoryLocalStorage = ({FutureFn<String>? baseDirFn, List<int>? encryptionKey, LocalStorageClearStrategy? clear}) {
  if (!kIsWeb) {
    baseDirFn ??= () => getApplicationDocumentsDirectory().then((dir) => dir.path);
  } else {
    baseDirFn ??= () => '';
  }
  
  return hiveLocalStorageProvider.overrideWith(
    (ref) => HiveLocalStorage(
      hive: ref.read(hiveProvider),
      baseDirFn: baseDirFn,
      encryptionKey: encryptionKey,
      clear: clear,
    ),
  );
};

final repositoryProviders = <String, Provider<Repository<DataModelMixin>>>{
  'categories': categoriesRepositoryProvider,
'places': placesRepositoryProvider,
'products': productsRepositoryProvider,
'receipts': receiptsRepositoryProvider,
'users': usersRepositoryProvider
};

final repositoryInitializerProvider =
  FutureProvider<RepositoryInitializer>((ref) async {
    DataHelpers.setInternalType<Category>('categories');
    DataHelpers.setInternalType<Place>('places');
    DataHelpers.setInternalType<Product>('products');
    DataHelpers.setInternalType<Receipt>('receipts');
    DataHelpers.setInternalType<User>('users');
    final adapters = <String, RemoteAdapter>{'categories': ref.watch(internalCategoriesRemoteAdapterProvider), 'places': ref.watch(internalPlacesRemoteAdapterProvider), 'products': ref.watch(internalProductsRemoteAdapterProvider), 'receipts': ref.watch(internalReceiptsRemoteAdapterProvider), 'users': ref.watch(internalUsersRemoteAdapterProvider)};
    final remotes = <String, bool>{'categories': true, 'places': true, 'products': true, 'receipts': true, 'users': true};

    await ref.watch(graphNotifierProvider).initialize();

    // initialize and register
    for (final type in repositoryProviders.keys) {
      final repository = ref.read(repositoryProviders[type]!);
      repository.dispose();
      await repository.initialize(
        remote: remotes[type],
        adapters: adapters,
      );
      internalRepositories[type] = repository;
    }

    return RepositoryInitializer();
});
extension RepositoryWidgetRefX on WidgetRef {
  Repository<Category> get categories => watch(categoriesRepositoryProvider)..remoteAdapter.internalWatch = watch;
  Repository<Place> get places => watch(placesRepositoryProvider)..remoteAdapter.internalWatch = watch;
  Repository<Product> get products => watch(productsRepositoryProvider)..remoteAdapter.internalWatch = watch;
  Repository<Receipt> get receipts => watch(receiptsRepositoryProvider)..remoteAdapter.internalWatch = watch;
  Repository<User> get users => watch(usersRepositoryProvider)..remoteAdapter.internalWatch = watch;
}

extension RepositoryRefX on Ref {

  Repository<Category> get categories => watch(categoriesRepositoryProvider)..remoteAdapter.internalWatch = watch as Watcher;
  Repository<Place> get places => watch(placesRepositoryProvider)..remoteAdapter.internalWatch = watch as Watcher;
  Repository<Product> get products => watch(productsRepositoryProvider)..remoteAdapter.internalWatch = watch as Watcher;
  Repository<Receipt> get receipts => watch(receiptsRepositoryProvider)..remoteAdapter.internalWatch = watch as Watcher;
  Repository<User> get users => watch(usersRepositoryProvider)..remoteAdapter.internalWatch = watch as Watcher;
}