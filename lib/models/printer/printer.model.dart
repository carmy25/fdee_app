import 'package:flutter/foundation.dart';
import 'package:fudiee/models/receipt/receipt.model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:charset/charset.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'printer.model.g.dart';

@riverpod
class Printer extends _$Printer {
  BluetoothConnection? _connection;
  @override
  Future<String> build() async {
    debugPrint('Printer.build');
    return await _getAddress();
  }

  Future<String> _getAddress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('printer_address') ?? '';
  }

  Future<void> setAddress(String address) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('printer_address', address);
    state = AsyncData(address);
  }

  Future<BluetoothConnection> connect(String address) async {
    final conn = await BluetoothConnection.toAddress(address);
    _connection = conn;
    debugPrint("✅ Підключено до $address");
    return conn;
  }

  Future<void> disconnect() async {
    try {
      final connection = _connection;
      if (connection != null) {
        await Future.delayed(const Duration(seconds: 4));
        // await connection.close();
        // _connection = null;
      }
    } catch (e) {
      debugPrint("❌ Помилка відключення: $e");
    }
  }

  Future<List<int>> _createReceiptTicket(Receipt receipt) async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile, codec: cp866);
    List<int> bytes = [];

    bytes.addAll([0x1B, 0x74, 0x11]);
    bytes += generator.text('Family Кафе',
        linesAfter: 1,
        styles: PosStyles(
            align: PosAlign.center,
            height: PosTextSize.size2,
            width: PosTextSize.size2,
            bold: true));
    final now = DateTime.now();
    bytes += generator.text(
      'Дата: ${now.toLocal().toString().substring(0, 19)}',
      styles: PosStyles(align: PosAlign.center),
    );
    bytes += generator.hr();

    bytes += generator.row([
      PosColumn(text: 'Назва', width: 6, styles: PosStyles(bold: true)),
      PosColumn(text: 'К-сть', width: 3, styles: PosStyles(bold: true)),
      PosColumn(
          text: 'Цiна(грн)',
          width: 3,
          styles: PosStyles(align: PosAlign.right, bold: true)),
    ]);

    for (final item in receipt.productItems) {
      final name = item.name.replaceAll('і', 'i');
      bytes += generator.row([
        PosColumn(text: name, width: 6),
        PosColumn(text: item.amount.toString(), width: 2),
        PosColumn(
            text: '${item.getTotal()}',
            width: 4,
            styles: PosStyles(align: PosAlign.right)),
      ]);
    }
    bytes += generator.hr();
    bytes += generator.row([
      PosColumn(
          text: 'СУМА',
          width: 6,
          styles: PosStyles(align: PosAlign.right, bold: true)),
      PosColumn(
          text: '${receipt.getTotal()} грн',
          width: 6,
          styles: PosStyles(align: PosAlign.right, bold: true)),
    ]);
    bytes += generator.feed(1);
    bytes += generator.text(
      'Дякуємо за вiзит!',
      styles: PosStyles(align: PosAlign.center, bold: true),
    );
    bytes += generator.feed(2);

    bytes += generator.cut();

    return bytes;
  }

  Future<void> print(Receipt receipt) async {
    final ticket = await _createReceiptTicket(receipt);
    final c = _connection;
    if (c != null) {
      c.output.add(Uint8List.fromList(ticket));
      await c.output.allSent;
      return;
    }
    debugPrint('No connection to printer available');
  }
}
