import 'package:flutter/material.dart';
import 'package:fudiee/screens/home/widgets/app_circle_image.dart';
import 'package:fudiee/themes/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryCard extends ConsumerWidget {
  const CategoryCard({
    super.key,
    required this.category,
    required this.image,
    required this.selected,
    required this.onSelected,
  });

  final String category;
  final String image;
  final bool selected;
  final ValueChanged onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [lightBoxShadow],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Material(
          type: MaterialType.card,
          child: InkWell(
            onTap: () => onSelected(!selected),
            child: Ink(
              width: 119,
              // alignment: Alignment.center,
              color: selected ? lightAmberColor : Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppCircleImage(image: image),
                  Text(category),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

var lightBoxShadow = BoxShadow(
  blurRadius: 5,
  spreadRadius: 1,
  color: greyColor.withOpacity(0.5),
  offset: const Offset(0, 1),
);
