import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'active_category.model.g.dart';

@riverpod
class ActiveCategory extends _$ActiveCategory {
  @override
  int? build() {
    debugPrint('ActiveCategory.build');
    return null;
  }

  void setActiveCategory(int? categoryId) {
    debugPrint('setActiveCategory: $categoryId');
    state = categoryId;
  }

  void clearActiveCategory() {
    state = null;
  }
}
