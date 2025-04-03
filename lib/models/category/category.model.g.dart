// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.model.dart';

// **************************************************************************
// AdapterGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, duplicate_ignore

mixin _$CategoryAdapter on Adapter<Category> {
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
  Category deserializeLocal(map, {String? key}) {
    map = transformDeserialize(map);
    return internalWrapStopInit(() => _$CategoryFromJson(map), key: key);
  }

  @override
  Map<String, dynamic> serializeLocal(model, {bool withRelationships = true}) {
    final map = _$CategoryToJson(model);
    return transformSerialize(map, withRelationships: withRelationships);
  }
}

final _categoriesFinders = <String, dynamic>{};

class $CategoryAdapter = Adapter<Category>
    with
        _$CategoryAdapter,
        JsonBaseAdapter<Category>,
        CategoryAdapter<Category>;

final categoriesAdapterProvider = Provider<Adapter<Category>>(
    (ref) => $CategoryAdapter(ref, InternalHolder(_categoriesFinders)));

extension CategoryAdapterX on Adapter<Category> {
  JsonBaseAdapter<Category> get jsonBaseAdapter =>
      this as JsonBaseAdapter<Category>;
  CategoryAdapter<Category> get categoryAdapter =>
      this as CategoryAdapter<Category>;
}

extension CategoryRelationshipGraphNodeX on RelationshipGraphNode<Category> {
  RelationshipGraphNode<Product> get products {
    final meta = _$CategoryAdapter._kCategoryRelationshipMetas['products']
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
