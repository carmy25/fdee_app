import 'dart:convert';

import 'package:flutter_data/flutter_data.dart';
import 'package:fudiee/models/base/base.adapter.dart';
import 'package:fudiee/models/product/product.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.model.g.dart';

@JsonSerializable()
@DataAdapter([JsonBaseAdapter, CategoryAdapter])
// ignore: must_be_immutable
class Category extends DataModel<Category> {
  @override
  final int? id;
  @JsonKey(
    fromJson: _nameFromJson,
  )
  final String name;
  final String? image;
  final String parent;
  final HasMany<Product>? products;

  Category({
    this.id,
    required this.name,
    required this.image,
    required this.parent,
    this.products,
  });

  static String _nameFromJson(String? value) {
    try {
      return utf8.decode(value?.codeUnits ?? []);
    } catch (e) {
      return value ?? '';
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          image == other.image &&
          parent == other.parent;

  @override
  int get hashCode => Object.hash(id, name, image, parent);
}

mixin CategoryAdapter<T extends DataModel<T>> on Adapter<T> {
  static String basePath = 'order';
  @override
  String get baseUrl => '${super.baseUrl}/$basePath/';
}
