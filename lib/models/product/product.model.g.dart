// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.model.dart';

// **************************************************************************
// AdapterGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, duplicate_ignore

mixin _$ProductAdapter on Adapter<Product> {
  static final Map<String, RelationshipMeta> _kProductRelationshipMetas = {
    'categoryObject': RelationshipMeta<Category>(
      name: 'categoryObject',
      inverseName: 'products',
      type: 'categories',
      kind: 'BelongsTo',
      instance: (_) => (_ as Product).categoryObject,
    )
  };

  @override
  Map<String, RelationshipMeta> get relationshipMetas =>
      _kProductRelationshipMetas;

  @override
  Product deserializeLocal(map, {String? key}) {
    map = transformDeserialize(map);
    return internalWrapStopInit(() => _$ProductFromJson(map), key: key);
  }

  @override
  Map<String, dynamic> serializeLocal(model, {bool withRelationships = true}) {
    final map = _$ProductToJson(model);
    return transformSerialize(map, withRelationships: withRelationships);
  }
}

final _productsFinders = <String, dynamic>{};

class $ProductAdapter = Adapter<Product>
    with _$ProductAdapter, JsonProductAdapter<Product>;

final productsAdapterProvider = Provider<Adapter<Product>>(
    (ref) => $ProductAdapter(ref, InternalHolder(_productsFinders)));

extension ProductAdapterX on Adapter<Product> {
  JsonProductAdapter<Product> get jsonProductAdapter =>
      this as JsonProductAdapter<Product>;
}

extension ProductRelationshipGraphNodeX on RelationshipGraphNode<Product> {
  RelationshipGraphNode<Category> get categoryObject {
    final meta = _$ProductAdapter._kProductRelationshipMetas['categoryObject']
        as RelationshipMeta<Category>;
    return meta.clone(
        parent: this is RelationshipMeta ? this as RelationshipMeta : null);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: (json['id'] as num).toInt(),
      name: Product._nameFromJson(json['name'] as String?),
      price: json['price'] as num,
      category: json['category'] as String,
      image: json['image'] as String?,
      categoryObject: json['categoryObject'] == null
          ? null
          : BelongsTo<Category>.fromJson(
              json['categoryObject'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'category': instance.category,
      'image': instance.image,
      'categoryObject': instance.categoryObject,
    };
