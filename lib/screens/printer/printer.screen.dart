import 'package:charset/charset.dart';
import 'package:charset_converter/charset_converter.dart';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';

class PrinterScreen extends StatefulWidget {
  static final name = 'PrinterScreen';
  static final routePath = '/printer';

  const PrinterScreen({super.key});
  @override
  _PrinterScreenState createState() => _PrinterScreenState();
}

class _PrinterScreenState extends State<PrinterScreen> {
  FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;
  List<BluetoothDevice> devices = [];
  BluetoothConnection? connection;
  BluetoothDevice? selectedDevice;

  @override
  void initState() {
    super.initState();
    _getDevices();
  }

  /// Отримати список з’єднаних Bluetooth-пристроїв
  Future<void> _getDevices() async {
    List<BluetoothDevice> pairedDevices = await bluetooth.getBondedDevices();
    setState(() {
      devices = pairedDevices;
    });
  }

  _cp866() async {
    final result = await CharsetConverter.encode(
        "CP866", "Чек #123\n1x Кава - 50.00 UAH\nДякуємо за покупку!\n\n");
    return result;
  }

  /// Підключитися до вибраного принтера
  Future<void> _connect(BluetoothDevice device) async {
    try {
      connection = await BluetoothConnection.toAddress(device.address);
      setState(() {
        selectedDevice = device;
      });
      print("✅ Підключено до ${device.name}");
    } catch (e) {
      print("❌ Помилка підключення: $e");
    }
  }

  /// Створити чек
  Future<List<int>> _createReceipt() async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile, codec: cp866);
    List<int> bytes = [];

    bytes.addAll([0x1B, 0x74, 0x11]);
    bytes += generator.text('===== Чек =====',
        styles: PosStyles(
            align: PosAlign.center,
            height: PosTextSize.size2,
            width: PosTextSize.size2,
            bold: true));
    bytes += generator.text(DateTime.now().toString());
    bytes += generator.hr();
    bytes += generator.text('1x Кава - 50.00 UAH');
    bytes += generator.text('Total: 75.00 UAH',
        styles: PosStyles(align: PosAlign.right, bold: true));
    bytes += generator.feed(2);
    bytes += generator.cut();

    return bytes;
  }

  /// Надрукувати чек
  Future<void> _printReceipt() async {
    if (connection == null) {
      print("❌ Спочатку підключіться до принтера!");
      return;
    }

    final ticket = await _createReceipt();
    connection!.output.add(Uint8List.fromList(ticket));
    await connection!.output.allSent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bluetooth Принтери")),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: _getDevices, child: Text("🔄 Оновити список")),
          Expanded(
            child: ListView.builder(
              itemCount: devices.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(devices[index].name ?? "Невідомий пристрій"),
                  subtitle: Text(devices[index].address),
                  trailing: selectedDevice == devices[index]
                      ? Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () => _connect(devices[index]),
                );
              },
            ),
          ),
          if (selectedDevice != null)
            ElevatedButton(
              onPressed: _printReceipt,
              child: Text("🖨️ Друк чека"),
            ),
        ],
      ),
    );
  }
}
