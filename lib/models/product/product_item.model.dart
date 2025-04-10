import 'dart:convert';

import 'package:flutter_data/flutter_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_item.model.g.dart';

@JsonSerializable()
@DataAdapter([])
// ignore: must_be_immutable
class ProductItem extends DataModel<ProductItem> {
  @override
  final int? id;
  final num price;
  final int amount;
  @JsonKey(
    fromJson: _nameFromJson,
  )
  final String name;
  final String? image;
  @JsonKey(
    name: 'root_category',
    fromJson: _nameFromJson,
  )
  final String rootCategory;
  @JsonKey(
    name: 'product_type',
  )
  final int productId;
  final int? receiptId;

  static String _nameFromJson(String? value) {
    try {
      return utf8.decode(value?.codeUnits ?? []);
    } catch (e) {
      return value ?? '';
    }
  }

  num getTotal() {
    return price * amount;
  }

  ProductItem(
      {this.id,
      required this.name,
      required this.amount,
      required this.price,
      required this.image,
      required this.productId,
      required this.rootCategory,
      this.receiptId});

  Map<String, dynamic> toJson() => _$ProductItemToJson(this);
}
