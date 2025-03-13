import 'package:json_annotation/json_annotation.dart';

part 'product_item.model.g.dart';

@JsonSerializable()
class ProductItem {
  final int? id;
  final String price;
  final int amount;
  final String name;
  final String? image;
  final int? productId;
  final int? receiptId;
  ProductItem(
      {this.id,
      required this.name,
      required this.amount,
      required this.price,
      required this.image,
      required this.productId,
      this.receiptId});

  Map<String, dynamic> toJson() => _$ProductItemToJson(this);
  factory ProductItem.fromJson(Map<String, dynamic> json) =>
      _$ProductItemFromJson(json);
}
