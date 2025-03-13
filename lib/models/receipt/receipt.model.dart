import 'dart:convert';

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

  @JsonKey(
    name: 'created_at',
    toJson: _createdAtToJson,
    fromJson: _createdAtFromJson,
  )
  final DateTime? createdAt;

  @JsonKey(
    name: 'payment_method',
  )
  final String paymentMethod;
  final double price;
  @JsonKey(
    name: 'place_name',
    fromJson: _placeNameFromJson,
  )
  final String? placeName;
  @JsonKey(
    name: 'product_items',
  )
  final List<ProductItem> productItems;

  Receipt(
      {this.id,
      this.place,
      this.number,
      this.createdAt,
      this.price = 0,
      required this.productItems,
      required this.paymentMethod,
      this.placeName});

  Map<String, dynamic> toJson() => _$ReceiptToJson(this);
  static String _createdAtToJson(DateTime? value) =>
      value?.toIso8601String() ?? '';
  static DateTime _createdAtFromJson(String value) => DateTime.parse(value);
  static String _placeNameFromJson(String? value) {
    try {
      return utf8.decode(value?.codeUnits ?? []);
    } catch (e) {
      return value ?? '';
    }
  }

  Receipt copyWith({
    int? id,
    int? place,
    num? number,
    DateTime? createdAt,
    String? paymentMethod,
    double? price,
    String? placeName,
    List<ProductItem>? productItems,
  }) {
    return Receipt(
      id: id ?? this.id,
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
      return previousValue + element.amount * double.parse(element.price);
    });
  }
}

mixin ReceiptAdapter<T extends DataModel<T>> on RemoteAdapter<T> {
  static String basePath = 'order';

  @override
  String get baseUrl => '${super.baseUrl}/$basePath/';
}
