// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_item.model.dart';

// **************************************************************************
// AdapterGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, duplicate_ignore

mixin _$ProductItemAdapter on Adapter<ProductItem> {
  static final Map<String, RelationshipMeta> _kProductItemRelationshipMetas =
      {};

  @override
  Map<String, RelationshipMeta> get relationshipMetas =>
      _kProductItemRelationshipMetas;

  @override
  ProductItem deserializeLocal(map, {String? key}) {
    map = transformDeserialize(map);
    return internalWrapStopInit(() => _$ProductItemFromJson(map), key: key);
  }

  @override
  Map<String, dynamic> serializeLocal(model, {bool withRelationships = true}) {
    final map = model.toJson();
    return transformSerialize(map, withRelationships: withRelationships);
  }
}

final _productItemsFinders = <String, dynamic>{};

class $ProductItemAdapter = Adapter<ProductItem>
    with _$ProductItemAdapter, NothingMixin;

final productItemsAdapterProvider = Provider<Adapter<ProductItem>>(
    (ref) => $ProductItemAdapter(ref, InternalHolder(_productItemsFinders)));

extension ProductItemAdapterX on Adapter<ProductItem> {}

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
