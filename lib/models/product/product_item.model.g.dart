// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_item.model.dart';

// **************************************************************************
// RepositoryGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, duplicate_ignore

mixin $ProductItemLocalAdapter on LocalAdapter<ProductItem> {
  static final Map<String, RelationshipMeta> _kProductItemRelationshipMetas =
      {};

  @override
  Map<String, RelationshipMeta> get relationshipMetas =>
      _kProductItemRelationshipMetas;

  @override
  ProductItem deserialize(map) {
    map = transformDeserialize(map);
    return _$ProductItemFromJson(map);
  }

  @override
  Map<String, dynamic> serialize(model, {bool withRelationships = true}) {
    final map = model.toJson();
    return transformSerialize(map, withRelationships: withRelationships);
  }
}

final _productItemsFinders = <String, dynamic>{};

// ignore: must_be_immutable
class $ProductItemHiveLocalAdapter = HiveLocalAdapter<ProductItem>
    with $ProductItemLocalAdapter;

class $ProductItemRemoteAdapter = RemoteAdapter<ProductItem> with NothingMixin;

final internalProductItemsRemoteAdapterProvider =
    Provider<RemoteAdapter<ProductItem>>((ref) => $ProductItemRemoteAdapter(
        $ProductItemHiveLocalAdapter(ref),
        InternalHolder(_productItemsFinders)));

final productItemsRepositoryProvider =
    Provider<Repository<ProductItem>>((ref) => Repository<ProductItem>(ref));

extension ProductItemDataRepositoryX on Repository<ProductItem> {}

extension ProductItemRelationshipGraphNodeX
    on RelationshipGraphNode<ProductItem> {}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductItem _$ProductItemFromJson(Map<String, dynamic> json) => ProductItem(
      id: (json['id'] as num?)?.toInt(),
      name: ProductItem._nameFromJson(json['name'] as String?),
      amount: (json['amount'] as num).toInt(),
      price: json['price'] as num,
      image: json['image'] as String?,
      productId: (json['product_type'] as num).toInt(),
      rootCategory: ProductItem._nameFromJson(json['root_category'] as String?),
      receiptId: (json['receiptId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductItemToJson(ProductItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'amount': instance.amount,
      'name': instance.name,
      'image': instance.image,
      'root_category': instance.rootCategory,
      'product_type': instance.productId,
      'receiptId': instance.receiptId,
    };
