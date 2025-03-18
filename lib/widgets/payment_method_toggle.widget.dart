import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class PaymentMethodController extends ValueNotifier<String> {
  PaymentMethodController([super.value = 'CARD']);
}

class PaymentMethodToggle extends StatelessWidget {
  const PaymentMethodToggle({super.key, required this.controller});

  final PaymentMethodController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8.0),
      child: ToggleSwitch(
        minWidth: 120.0,
        minHeight: 60.0,
        cornerRadius: 20.0,
        activeBgColor: [Colors.green],
        activeFgColor: Colors.white,
        inactiveBgColor: Colors.grey,
        inactiveFgColor: Colors.white,
        labels: const ['Картка', 'Готівка'],
        icons: const [Icons.credit_card, Icons.attach_money],
        initialLabelIndex: controller.value == 'CARD' ? 0 : 1,
        onToggle: (index) {
          controller.value = index == 0 ? 'CARD' : 'CASH';
          debugPrint('switched to: ${controller.value}');
        },
      ),
    );
  }
}
