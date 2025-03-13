// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.model.dart';

// **************************************************************************
// RepositoryGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, duplicate_ignore

mixin $ProductLocalAdapter on LocalAdapter<Product> {
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
  Product deserialize(map) {
    map = transformDeserialize(map);
    return _$ProductFromJson(map);
  }

  @override
  Map<String, dynamic> serialize(model, {bool withRelationships = true}) {
    final map = _$ProductToJson(model);
    return transformSerialize(map, withRelationships: withRelationships);
  }
}

final _productsFinders = <String, dynamic>{};

// ignore: must_be_immutable
class $ProductHiveLocalAdapter = HiveLocalAdapter<Product>
    with $ProductLocalAdapter;

class $ProductRemoteAdapter = RemoteAdapter<Product>
    with JsonProductAdapter<Product>;

final internalProductsRemoteAdapterProvider = Provider<RemoteAdapter<Product>>(
    (ref) => $ProductRemoteAdapter(
        $ProductHiveLocalAdapter(ref), InternalHolder(_productsFinders)));

final productsRepositoryProvider =
    Provider<Repository<Product>>((ref) => Repository<Product>(ref));

extension ProductDataRepositoryX on Repository<Product> {
  JsonProductAdapter<Product> get jsonProductAdapter =>
      remoteAdapter as JsonProductAdapter<Product>;
}

extension ProductRelationshipGraphNodeX on RelationshipGraphNode<Product> {
  RelationshipGraphNode<Category> get categoryObject {
    final meta =
        $ProductLocalAdapter._kProductRelationshipMetas['categoryObject']
            as RelationshipMeta<Category>;
    return meta.clone(
        parent: this is RelationshipMeta ? this as RelationshipMeta : null);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: (json['id'] as num?)?.toInt(),
      name: Product._nameFromJson(json['name'] as String?),
      price: json['price'] as String,
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
