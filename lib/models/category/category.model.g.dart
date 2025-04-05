// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.model.dart';

// **************************************************************************
// RepositoryGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, duplicate_ignore

mixin $CategoryLocalAdapter on LocalAdapter<Category> {
  static final Map<String, RelationshipMeta> _kCategoryRelationshipMetas = {
    'products': RelationshipMeta<Product>(
      name: 'products',
      inverseName: 'categoryObject',
      type: 'products',
      kind: 'HasMany',
      instance: (_) => (_ as Category).products,
    )
  };

  @override
  Map<String, RelationshipMeta> get relationshipMetas =>
      _kCategoryRelationshipMetas;

  @override
  Category deserialize(map) {
    map = transformDeserialize(map);
    return _$CategoryFromJson(map);
  }

  @override
  Map<String, dynamic> serialize(model, {bool withRelationships = true}) {
    final map = _$CategoryToJson(model);
    return transformSerialize(map, withRelationships: withRelationships);
  }
}

final _categoriesFinders = <String, dynamic>{};

// ignore: must_be_immutable
class $CategoryHiveLocalAdapter = HiveLocalAdapter<Category>
    with $CategoryLocalAdapter;

class $CategoryRemoteAdapter = RemoteAdapter<Category>
    with JsonBaseAdapter<Category>, CategoryAdapter<Category>;

final internalCategoriesRemoteAdapterProvider =
    Provider<RemoteAdapter<Category>>((ref) => $CategoryRemoteAdapter(
        $CategoryHiveLocalAdapter(ref), InternalHolder(_categoriesFinders)));

final categoriesRepositoryProvider =
    Provider<Repository<Category>>((ref) => Repository<Category>(ref));

extension CategoryDataRepositoryX on Repository<Category> {
  JsonBaseAdapter<Category> get jsonBaseAdapter =>
      remoteAdapter as JsonBaseAdapter<Category>;
  CategoryAdapter<Category> get categoryAdapter =>
      remoteAdapter as CategoryAdapter<Category>;
}

extension CategoryRelationshipGraphNodeX on RelationshipGraphNode<Category> {
  RelationshipGraphNode<Product> get products {
    final meta = $CategoryLocalAdapter._kCategoryRelationshipMetas['products']
        as RelationshipMeta<Product>;
    return meta.clone(
        parent: this is RelationshipMeta ? this as RelationshipMeta : null);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: (json['id'] as num?)?.toInt(),
      name: Category._nameFromJson(json['name'] as String?),
      image: json['image'] as String?,
      parent: json['parent'] as String,
      products: json['products'] == null
          ? null
          : HasMany<Product>.fromJson(json['products'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'parent': instance.parent,
      'products': instance.products,
    };
