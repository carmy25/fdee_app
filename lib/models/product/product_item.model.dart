// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter_data/flutter_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_item.model.g.dart';

@JsonSerializable()
@DataAdapter([])
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

  ProductItem(
      {this.id,
      required this.name,
      required this.amount,
      required this.price,
      required this.image,
      required this.productId,
      this.receiptId});

  Map<String, dynamic> toJson() => _$ProductItemToJson(this);
}
