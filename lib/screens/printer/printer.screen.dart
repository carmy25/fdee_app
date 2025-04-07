import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudiee/models/printer/printer.model.dart';

class PrinterScreen extends ConsumerStatefulWidget {
  static final name = 'PrinterScreen';
  static final routePath = '/printer';

  const PrinterScreen({super.key});
  @override
  PrinterScreenState createState() => PrinterScreenState();
}

class PrinterScreenState extends ConsumerState<PrinterScreen> {
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

  /// Підключитися до вибраного принтера
  Future<void> _connect(BluetoothDevice device) async {
    try {
      connection = await BluetoothConnection.toAddress(device.address);
      setState(() {
        selectedDevice = device;
      });
      final printer = ref.read(printerProvider.notifier);
      await printer.setAddress(device.address);
      debugPrint("✅ Stored ${device.name} printer");
    } catch (e) {
      debugPrint("❌ Issue with storing printer address: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bluetooth Принтери"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
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
                  onTap: () async {
                    await _connect(devices[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
