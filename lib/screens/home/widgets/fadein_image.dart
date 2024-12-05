import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppFadeinImageView extends ConsumerWidget {
  const AppFadeinImageView({super.key, required this.image, this.fit});

  final ImageProvider<Object> image;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FadeInImage(
      placeholder: image,
      image: image,
      fit: fit,
    );
  }
}
