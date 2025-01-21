import 'package:flutter_data/flutter_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'product.model.g.dart';

@JsonSerializable()
@DataRepository([JsonProductAdapter])
class Product extends DataModel<Product> {
  @override
  final int? id;
  final String name;
  final double price;
  final String category;
  final String? image;

  Product(
      {this.id,
      required this.name,
      required this.price,
      required this.category,
      required this.image});
}

mixin JsonProductAdapter<T extends DataModel<T>> on RemoteAdapter<T> {
  @override
  String get baseUrl => 'http://192.168.5.153:8000/order/products/';

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
