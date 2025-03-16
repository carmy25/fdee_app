import 'dart:convert';

import 'package:flutter_data/flutter_data.dart';
import 'package:fudiee/models/category/category.model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'product.model.g.dart';

@JsonSerializable()
@DataRepository([JsonProductAdapter])
class Product extends DataModel<Product> {
  @override
  final int id;
  @JsonKey(
    fromJson: _nameFromJson,
  )
  final String name;
  final num price;
  final String category;
  final String? image;
  final BelongsTo<Category>? categoryObject;
  static String _nameFromJson(String? value) {
    try {
      return utf8.decode(value?.codeUnits ?? []);
    } catch (e) {
      return value ?? '';
    }
  }

  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.category,
      required this.image,
      required this.categoryObject});
}

mixin JsonProductAdapter<T extends DataModel<T>> on RemoteAdapter<T> {
  @override
  String get baseUrl => '${const String.fromEnvironment(
        'BE_HOST',
      )}/order/products/';

  @override
  FutureOr<Map<String, String>> get defaultHeaders async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      return await super.defaultHeaders & {'Authorization': 'token $token'};
    }
    return super.defaultHeaders;
  }
}
