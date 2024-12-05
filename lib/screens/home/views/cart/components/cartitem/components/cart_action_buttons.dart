import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fudiee/themes/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartActionButtons extends ConsumerWidget {
  const CartActionButtons({
    super.key,
    required this.itemCount,
    required this.onReduce,
    required this.onAdd,
  });

  final num itemCount;
  final VoidCallback onReduce;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        IconButton(
          onPressed: onReduce,
          icon: Icon(
            CupertinoIcons.minus_circle_fill,
            size: 30,
            color: Colors.grey.shade600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Text(
            '$itemCount',
            style: const TextStyle(
              fontSize: 19,
            ),
          ),
        ),
        IconButton(
          onPressed: onAdd,
          icon: Icon(
            Icons.add_circle_rounded,
            size: 30,
            color: pinkColor,
          ),
        ),
      ],
    );
  }
}
