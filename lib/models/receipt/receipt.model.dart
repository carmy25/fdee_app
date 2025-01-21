import 'package:flutter_data/flutter_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'receipt.model.g.dart';

@JsonSerializable()
@DataRepository([JsonReceiptAdapter])
class Receipt extends DataModel<Receipt> {
  @override
  final int? id;
  final String place;
  final int number;
  final DateTime createdAt;
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
}

mixin JsonReceiptAdapter<T extends DataModel<T>> on RemoteAdapter<T> {
  @override
  String get baseUrl => 'http://10.0.2.2:8000/order/receipts/';

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
