import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toggle_switch/toggle_switch.dart';

class PaymentMethodController extends ValueNotifier<String> {
  PaymentMethodController([super.value = 'CARD']);
}

class PaymentMethodToggle extends StatelessWidget {
  const PaymentMethodToggle({super.key, required this.controller});

  final PaymentMethodController controller;

  _getInitialIndex() {
    if (controller.value == 'CARD') {
      return 0;
    } else if (controller.value == 'CASH') {
      return 1;
    } else {
      return 2;
    }
  }

  _getValueOnToggle(int? index) {
    if (index == 0) {
      return 'CARD';
    } else if (index == 1) {
      return 'CASH';
    } else {
      return 'CARD_TRANSFER';
    }
  }

  void _onToggle(int? index) {
    controller.value = _getValueOnToggle(index);
    debugPrint('switched to: ${controller.value}');
  }

  @override
  Widget build(BuildContext context) {
    final initialLabelIndex = _getInitialIndex();
    return Flexible(
      child: ToggleSwitch(
        minWidth: 90.0,
        minHeight: 55.0,
        fontSize: 14.sp,
        cornerRadius: 20.0,
        activeBgColor: [Colors.green],
        activeFgColor: Colors.white,
        inactiveBgColor: Colors.grey,
        inactiveFgColor: Colors.white,
        labels: const ['Картка', 'Готівка', 'Переказ'],
        icons: const [Icons.credit_card, Icons.attach_money, Icons.payment],
        initialLabelIndex: initialLabelIndex,
        onToggle: _onToggle,
      ),
    );
  }
}
