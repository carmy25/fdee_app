import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fudiee/models/base/base.adapter.dart';
import 'package:fudiee/models/product/product_item.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'receipt.model.g.dart';

@JsonSerializable()
@DataRepository([JsonBaseAdapter, ReceiptAdapter])
class Receipt extends DataModel<Receipt> {
  @override
  final int? id;

  final int? place;
  final num? number;
  final String status;

  @JsonKey(
    name: 'created_at',
    toJson: _createdAtToJson,
    fromJson: _createdAtFromJson,
  )
  final DateTime createdAt;

  @JsonKey(
    name: 'payment_method',
  )
  final String paymentMethod;
  final double price;
  @JsonKey(
      name: 'place_name', fromJson: _placeNameFromJson, includeToJson: false)
  final String? placeName;
  @JsonKey(
    name: 'product_items',
    fromJson: _productItemsFromJson,
    toJson: _productItemsToJson,
  )
  final List<ProductItem> productItems;

  Receipt({
    this.id,
    this.place,
    this.number,
    this.price = 0,
    required this.createdAt,
    required this.productItems,
    required this.paymentMethod,
    required this.status,
    this.placeName,
  });

  Map<String, dynamic> toJson() => _$ReceiptToJson(this);
  static String _createdAtToJson(DateTime? value) =>
      value?.toIso8601String() ?? '';
  static DateTime _createdAtFromJson(String value) {
    try {
      debugPrint('Trying to parse date: [$value]');
      return DateTime.parse(value);
    } catch (e) {
      return DateTime(1970, 1, 1); // Return a default date in case of error
    }
  }

  static String _placeNameFromJson(String? value) {
    try {
      return utf8.decode(value?.codeUnits ?? []);
    } catch (e) {
      return value ?? '';
    }
  }

  static String _nameFromJson(String? value) {
    try {
      return utf8.decode(value?.codeUnits ?? []);
    } catch (e) {
      return value ?? '';
    }
  }

  static List<ProductItem> _productItemsFromJson(List<dynamic> data) {
    return data.map((e) {
      debugPrint('ProductItem: ${e["product_type"]}');
      return ProductItem(
        id: (e['id'] as num?)?.toInt(),
        name: _nameFromJson(e['name'] as String),
        amount: (e['amount'] as num).toInt(),
        price: e['price'] as num,
        image: e['image'] as String?,
        productId: (e['product_type'] as num).toInt(),
        receiptId: (e['receiptId'] as num?)?.toInt(),
      );
    }).toList();
  }

  static List<Map<String, dynamic>> _productItemsToJson(
      List<ProductItem> items) {
    return items.map((item) => item.toJson()).toList();
  }

  Receipt copyWith({
    int? id,
    int? place,
    num? number,
    DateTime? createdAt,
    String? paymentMethod,
    double? price,
    String? placeName,
    String? status,
    List<ProductItem>? productItems,
    int? placeId,
  }) {
    return Receipt(
      id: id ?? this.id,
      status: status ?? this.status,
      place: place ?? this.place,
      number: number ?? this.number,
      createdAt: createdAt ?? this.createdAt,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      price: price ?? this.price,
      placeName: placeName ?? this.placeName,
      productItems: productItems ?? this.productItems,
    );
  }

  num getTotal() {
    return productItems.fold(0, (previousValue, element) {
      return previousValue + element.amount * element.price;
    });
  }
}

mixin ReceiptAdapter<T extends DataModel<T>> on RemoteAdapter<T> {
  static String basePath = 'order';

  @override
  String get baseUrl => '${super.baseUrl}/$basePath/';
}
