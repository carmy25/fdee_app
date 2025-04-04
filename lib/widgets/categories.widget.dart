import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudiee/main.data.dart';
import 'package:fudiee/models/category/active_category.model.dart';
import 'package:fudiee/widgets/category_card.widget.dart';
import 'package:fudiee/widgets/progress_indicator.widget.dart';

class CategoriesWidget extends ConsumerStatefulWidget {
  const CategoriesWidget({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CategoriesWidgetState();
}

class _CategoriesWidgetState extends ConsumerState<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    final state = ref.categories.watchAll(syncLocal: true, remote: true);
    if (state.isLoading) {
      return ProgressIndicatorWidget();
    }
    final categories = state.model;

    final activeCategory = ref.watch(activeCategoryProvider);
    if (activeCategory == null) {
      Future(() => ref
          .read(activeCategoryProvider.notifier)
          .setActiveCategory(categories.first.id));
    }

    return ListView.separated(
      clipBehavior: Clip.none,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      separatorBuilder: (context, index) => const SizedBox(width: 23),
      itemBuilder: (context, index) {
        final category = categories[index];
        return CategoryCard(
          category: category.name,
          image: category.image ?? 'assets/images/cake1.png',
          isImageFromInternet: category.image != null,
          onSelected: (value) {
            setState(() {
              if (value) {
                ref
                    .read(activeCategoryProvider.notifier)
                    .setActiveCategory(category.id);
              }
            });
          },
          selected: activeCategory == category.id,
        );
      },
    );
  }
}
