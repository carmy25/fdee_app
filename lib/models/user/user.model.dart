// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter_data/flutter_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.model.g.dart';

@JsonSerializable()
@DataRepository([JsonUserAdapter])
class User extends DataModel<User> {
  @override
  final int? id;
  final String token;

  User({
    this.id,
    required this.token,
  });
}

mixin JsonUserAdapter<T extends DataModel<T>> on RemoteAdapter<T> {
  @override
  String get baseUrl => '${const String.fromEnvironment(
        "BE_HOST",
      )}/user/api-token-auth/';
  Future<User?> signIn({
    required String username,
    required String password,
  }) async {
    final payload = {'username': username, 'password': password};

    return sendRequest(
      baseUrl.asUri,
      method: DataRequestMethod.POST,
      headers: await defaultHeaders,
      body: json.encode(payload),
    );
  }
}
