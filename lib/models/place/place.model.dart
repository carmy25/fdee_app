// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter_data/flutter_data.dart';
import 'package:fudiee/models/base/base.adapter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'place.model.g.dart';

@JsonSerializable()
@DataRepository([JsonBaseAdapter, PlaceAdapter])
class Place extends DataModel<Place> {
  @override
  final int? id;
  @JsonKey(
    fromJson: _nameFromJson,
  )
  final String name;

  Place({
    this.id,
    required this.name,
  });

  static String _nameFromJson(String? value) {
    try {
      return utf8.decode(value?.codeUnits ?? []);
    } catch (e) {
      return value ?? '';
    }
  }
}

mixin PlaceAdapter<T extends DataModel<T>> on RemoteAdapter<T> {
  static String basePath = 'place';
  @override
  String get baseUrl => '${super.baseUrl}/$basePath/';
}
