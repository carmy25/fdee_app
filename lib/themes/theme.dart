import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudiee/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData buildTheme(context) {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldBgColor,
      colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
      useMaterial3: true,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: defaultInputBorder,
        enabledBorder: defaultInputBorder,
        focusedBorder: defaultInputBorder.copyWith(
          borderSide: BorderSide(color: primaryColor),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 27.w,
          vertical: 20.h,
        ),
      ),
      textTheme: Theme.of(context).textTheme.merge(
            GoogleFonts.interTextTheme().copyWith(
                headlineSmall: GoogleFonts.inter(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w500,
                  color: primaryTextColor,
                ),
                labelLarge: const TextStyle(fontWeight: FontWeight.bold)),
          ),
    );
  }
}

var defaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(6),
  borderSide: BorderSide(
    color: primaryColor.withValues(alpha: .2),
    width: 0.8,
  ),
);
