// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_item.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductItem _$ProductItemFromJson(Map<String, dynamic> json) => ProductItem(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      amount: (json['amount'] as num).toInt(),
      price: json['price'] as String,
      image: json['image'] as String?,
      productId: (json['productId'] as num?)?.toInt(),
      receiptId: (json['receiptId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductItemToJson(ProductItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'amount': instance.amount,
      'name': instance.name,
      'image': instance.image,
      'productId': instance.productId,
      'receiptId': instance.receiptId,
    };
