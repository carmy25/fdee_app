import 'package:bluetooth_classic/models/device.dart';
import 'package:flutter/material.dart';
import 'package:bluetooth_classic/bluetooth_classic.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudiee/models/printer/printer.model.dart';
import 'package:permission_handler/permission_handler.dart';

class PrinterScreen extends ConsumerStatefulWidget {
  static final name = 'PrinterScreen';
  static final routePath = '/printer';

  const PrinterScreen({super.key});
  @override
  PrinterScreenState createState() => PrinterScreenState();
}

class PrinterScreenState extends ConsumerState<PrinterScreen> {
  final _bluetooth = BluetoothClassic();
  List<Device> _discoveredDevices = [];
  Device? _selectedDevice;

  @override
  void initState() {
    super.initState();
    _getDevices();
  }

  Future<void> _requestBluetoothPermission() async {
    if (await Permission.bluetoothConnect.request().isGranted) {
      debugPrint("Bluetooth CONNECT permission granted");
    } else {
      debugPrint("Bluetooth CONNECT permission denied");
    }
  }

  Future<void> _requestBluetoothScanPermission() async {
    if (await Permission.bluetoothScan.request().isGranted) {
      debugPrint("Bluetooth SCAN permission granted");
    } else {
      debugPrint("Bluetooth SCAN permission denied");
    }
  }

  Future<void> _requestPermissions() async {
    await _requestBluetoothPermission();
    await _requestBluetoothScanPermission();
  }

  Future<void> _getDevices() async {
    await _bluetooth.initPermissions();
    await _requestPermissions();
    final pairedDevices = await _bluetooth.getPairedDevices();
    setState(() {
      _discoveredDevices = pairedDevices;
    });
  }

  /// Підключитися до вибраного принтера
  Future<void> _connect(Device device) async {
    try {
      setState(() {
        _selectedDevice = device;
      });
      final printer = ref.read(printerProvider.notifier);
      await printer.setAddress(device.address);
      debugPrint("✅ Stored ${device.name} printer");
    } catch (e) {
      debugPrint("❌ Issue with storing printer address: $e");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bluetooth Принтери"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            final NavigatorState navigator = Navigator.of(context);
            if (mounted) {
              navigator.pop();
            }
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _discoveredDevices.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      _discoveredDevices[index].name ?? "Невідомий пристрій"),
                  subtitle: Text(_discoveredDevices[index].address),
                  trailing: _selectedDevice == _discoveredDevices[index]
                      ? Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () async {
                    await _connect(_discoveredDevices[index]);
                    await _bluetooth.stopScan();
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
