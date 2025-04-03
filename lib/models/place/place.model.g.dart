// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.model.dart';

// **************************************************************************
// AdapterGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, duplicate_ignore

mixin _$PlaceAdapter on Adapter<Place> {
  static final Map<String, RelationshipMeta> _kPlaceRelationshipMetas = {};

  @override
  Map<String, RelationshipMeta> get relationshipMetas =>
      _kPlaceRelationshipMetas;

  @override
  Place deserializeLocal(map, {String? key}) {
    map = transformDeserialize(map);
    return internalWrapStopInit(() => _$PlaceFromJson(map), key: key);
  }

  @override
  Map<String, dynamic> serializeLocal(model, {bool withRelationships = true}) {
    final map = _$PlaceToJson(model);
    return transformSerialize(map, withRelationships: withRelationships);
  }
}

final _placesFinders = <String, dynamic>{};

class $PlaceAdapter = Adapter<Place>
    with _$PlaceAdapter, JsonBaseAdapter<Place>, PlaceAdapter<Place>;

final placesAdapterProvider = Provider<Adapter<Place>>(
    (ref) => $PlaceAdapter(ref, InternalHolder(_placesFinders)));

extension PlaceAdapterX on Adapter<Place> {
  JsonBaseAdapter<Place> get jsonBaseAdapter => this as JsonBaseAdapter<Place>;
  PlaceAdapter<Place> get placeAdapter => this as PlaceAdapter<Place>;
}

extension PlaceRelationshipGraphNodeX on RelationshipGraphNode<Place> {}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Place _$PlaceFromJson(Map<String, dynamic> json) => Place(
      id: (json['id'] as num?)?.toInt(),
      name: Place._nameFromJson(json['name'] as String?),
    );

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
