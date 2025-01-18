// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.model.dart';

// **************************************************************************
// RepositoryGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, duplicate_ignore

mixin $ProductLocalAdapter on LocalAdapter<Product> {
  static final Map<String, RelationshipMeta> _kProductRelationshipMetas = {};

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

extension ProductRelationshipGraphNodeX on RelationshipGraphNode<Product> {}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      category: json['category'] as String,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'category': instance.category,
      'image': instance.image,
    };
