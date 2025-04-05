// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt.model.dart';

// **************************************************************************
// RepositoryGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, duplicate_ignore

mixin $ReceiptLocalAdapter on LocalAdapter<Receipt> {
  static final Map<String, RelationshipMeta> _kReceiptRelationshipMetas = {};

  @override
  Map<String, RelationshipMeta> get relationshipMetas =>
      _kReceiptRelationshipMetas;

  @override
  Receipt deserialize(map) {
    map = transformDeserialize(map);
    return _$ReceiptFromJson(map);
  }

  @override
  Map<String, dynamic> serialize(model, {bool withRelationships = true}) {
    final map = model.toJson();
    return transformSerialize(map, withRelationships: withRelationships);
  }
}

final _receiptsFinders = <String, dynamic>{};

// ignore: must_be_immutable
class $ReceiptHiveLocalAdapter = HiveLocalAdapter<Receipt>
    with $ReceiptLocalAdapter;

class $ReceiptRemoteAdapter = RemoteAdapter<Receipt>
    with JsonBaseAdapter<Receipt>, ReceiptAdapter<Receipt>;

final internalReceiptsRemoteAdapterProvider = Provider<RemoteAdapter<Receipt>>(
    (ref) => $ReceiptRemoteAdapter(
        $ReceiptHiveLocalAdapter(ref), InternalHolder(_receiptsFinders)));

final receiptsRepositoryProvider =
    Provider<Repository<Receipt>>((ref) => Repository<Receipt>(ref));

extension ReceiptDataRepositoryX on Repository<Receipt> {
  JsonBaseAdapter<Receipt> get jsonBaseAdapter =>
      remoteAdapter as JsonBaseAdapter<Receipt>;
  ReceiptAdapter<Receipt> get receiptAdapter =>
      remoteAdapter as ReceiptAdapter<Receipt>;
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
