// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.model.dart';

// **************************************************************************
// AdapterGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, duplicate_ignore

mixin _$UserAdapter on Adapter<User> {
  static final Map<String, RelationshipMeta> _kUserRelationshipMetas = {};

  @override
  Map<String, RelationshipMeta> get relationshipMetas =>
      _kUserRelationshipMetas;

  @override
  User deserializeLocal(map, {String? key}) {
    map = transformDeserialize(map);
    return internalWrapStopInit(() => _$UserFromJson(map), key: key);
  }

  @override
  Map<String, dynamic> serializeLocal(model, {bool withRelationships = true}) {
    final map = _$UserToJson(model);
    return transformSerialize(map, withRelationships: withRelationships);
  }
}

final _usersFinders = <String, dynamic>{};

class $UserAdapter = Adapter<User> with _$UserAdapter, JsonUserAdapter<User>;

final usersAdapterProvider = Provider<Adapter<User>>(
    (ref) => $UserAdapter(ref, InternalHolder(_usersFinders)));

extension UserAdapterX on Adapter<User> {
  JsonUserAdapter<User> get jsonUserAdapter => this as JsonUserAdapter<User>;
}

extension UserRelationshipGraphNodeX on RelationshipGraphNode<User> {}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num?)?.toInt(),
      token: json['token'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
    };
