// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt.model.dart';

// **************************************************************************
// AdapterGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, duplicate_ignore

mixin _$ReceiptAdapter on Adapter<Receipt> {
  static final Map<String, RelationshipMeta> _kReceiptRelationshipMetas = {};

  @override
  Map<String, RelationshipMeta> get relationshipMetas =>
      _kReceiptRelationshipMetas;

  @override
  Receipt deserializeLocal(map, {String? key}) {
    map = transformDeserialize(map);
    return internalWrapStopInit(() => _$ReceiptFromJson(map), key: key);
  }

  @override
  Map<String, dynamic> serializeLocal(model, {bool withRelationships = true}) {
    final map = model.toJson();
    return transformSerialize(map, withRelationships: withRelationships);
  }
}

final _receiptsFinders = <String, dynamic>{};

class $ReceiptAdapter = Adapter<Receipt>
    with _$ReceiptAdapter, JsonBaseAdapter<Receipt>, ReceiptAdapter<Receipt>;

final receiptsAdapterProvider = Provider<Adapter<Receipt>>(
    (ref) => $ReceiptAdapter(ref, InternalHolder(_receiptsFinders)));

extension ReceiptAdapterX on Adapter<Receipt> {
  JsonBaseAdapter<Receipt> get jsonBaseAdapter =>
      this as JsonBaseAdapter<Receipt>;
  ReceiptAdapter<Receipt> get receiptAdapter => this as ReceiptAdapter<Receipt>;
}

extension ReceiptRelationshipGraphNodeX on RelationshipGraphNode<Receipt> {}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Receipt _$ReceiptFromJson(Map<String, dynamic> json) => Receipt(
      id: (json['id'] as num?)?.toInt(),
      place: (json['place'] as num?)?.toInt(),
      number: json['number'] as num?,
      price: (json['price'] as num?)?.toDouble() ?? 0,
      isSynced: json['is_synced'] as bool? ?? false,
      createdAt: Receipt._createdAtFromJson(json['created_at'] as String),
      productItems:
          Receipt._productItemsFromJson(json['product_items'] as List),
      paymentMethod: json['payment_method'] as String,
      status: json['status'] as String,
      placeName: Receipt._placeNameFromJson(json['place_name'] as String?),
    );

Map<String, dynamic> _$ReceiptToJson(Receipt instance) => <String, dynamic>{
      'id': instance.id,
      'place': instance.place,
      'number': instance.number,
      'status': instance.status,
      'created_at': Receipt._createdAtToJson(instance.createdAt),
      'payment_method': instance.paymentMethod,
      'price': instance.price,
      'product_items': Receipt._productItemsToJson(instance.productItems),
    };
