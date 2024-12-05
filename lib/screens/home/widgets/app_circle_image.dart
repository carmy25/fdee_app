import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppCircleImage extends ConsumerWidget {
  const AppCircleImage({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: SizedBox(
        height: 60,
        width: 60,
        child: Image.asset(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
