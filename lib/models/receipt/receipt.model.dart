import 'dart:convert';

import 'package:flutter_data/flutter_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'receipt.model.g.dart';

@JsonSerializable()
@DataRepository([JsonReceiptAdapter])
class Receipt extends DataModel<Receipt> {
  @override
  final int? id;

  @JsonKey(
    fromJson: _placeFromJson,
  )
  final String? place;
  final num number;

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

  Receipt({
    this.id,
    required this.place,
    required this.number,
    required this.createdAt,
    required this.paymentMethod,
    required this.price,
  });

  Map<String, dynamic> toJson() => _$ReceiptToJson(this);
  static String _createdAtToJson(DateTime value) => value.toIso8601String();
  static DateTime _createdAtFromJson(String value) => DateTime.parse(value);
  static String _placeFromJson(String? value) {
    try {
      return utf8.decode(value?.codeUnits ?? []);
    } catch (e) {
      return value ?? '';
    }
  }
}

mixin JsonReceiptAdapter<T extends DataModel<T>> on RemoteAdapter<T> {
  @override
  String get baseUrl => 'http://192.168.5.153:8000/order/';

  @override
  FutureOr<Map<String, String>> get defaultHeaders async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      return {'Content-Type': 'application/json; charset=utf-8'} &
          {'Authorization': 'token $token'};
    }
    return super.defaultHeaders;
  }
}
