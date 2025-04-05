// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.model.dart';

// **************************************************************************
// RepositoryGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, duplicate_ignore

mixin $PlaceLocalAdapter on LocalAdapter<Place> {
  static final Map<String, RelationshipMeta> _kPlaceRelationshipMetas = {};

  @override
  Map<String, RelationshipMeta> get relationshipMetas =>
      _kPlaceRelationshipMetas;

  @override
  Place deserialize(map) {
    map = transformDeserialize(map);
    return _$PlaceFromJson(map);
  }

  @override
  Map<String, dynamic> serialize(model, {bool withRelationships = true}) {
    final map = _$PlaceToJson(model);
    return transformSerialize(map, withRelationships: withRelationships);
  }
}

final _placesFinders = <String, dynamic>{};

// ignore: must_be_immutable
class $PlaceHiveLocalAdapter = HiveLocalAdapter<Place> with $PlaceLocalAdapter;

class $PlaceRemoteAdapter = RemoteAdapter<Place>
    with JsonBaseAdapter<Place>, PlaceAdapter<Place>;

final internalPlacesRemoteAdapterProvider = Provider<RemoteAdapter<Place>>(
    (ref) => $PlaceRemoteAdapter(
        $PlaceHiveLocalAdapter(ref), InternalHolder(_placesFinders)));

final placesRepositoryProvider =
    Provider<Repository<Place>>((ref) => Repository<Place>(ref));

extension PlaceDataRepositoryX on Repository<Place> {
  JsonBaseAdapter<Place> get jsonBaseAdapter =>
      remoteAdapter as JsonBaseAdapter<Place>;
  PlaceAdapter<Place> get placeAdapter => remoteAdapter as PlaceAdapter<Place>;
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
