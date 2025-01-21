import 'package:flutter/material.dart';
import 'package:fudiee/constants/assets_constant.dart';
import 'package:fudiee/themes/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchBar extends ConsumerWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: _inputBorder,
        focusedBorder: _inputBorder.copyWith(
          borderSide: BorderSide(
            color: primaryColor.withValues(alpha: .4),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
        ),
        hintText: 'Search -> Grilled chicken -> Pizza',
        suffixIcon: Image.asset(Assets.searchIcon),
      ),
    );
  }
}

var _inputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(30),
  borderSide: BorderSide(
    color: primaryColor.withValues(alpha: .3),
    width: 0.8,
  ),
);
