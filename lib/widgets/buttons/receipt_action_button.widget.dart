import 'package:flutter/material.dart';

class ReceiptActionButtonWidget extends StatelessWidget {
  const ReceiptActionButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
    this.backgroundColor,
  });

  final VoidCallback onPressed;
  final String text;
  final Color? backgroundColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 35),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: Icon(icon, color: Colors.white, size: 30),
        label: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ));
  }
}
