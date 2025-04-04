import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: Icon(icon, color: Colors.white, size: 24.sp),
        label: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
            color: Colors.white,
          ),
          overflow: TextOverflow.ellipsis,
        ));
  }
}
