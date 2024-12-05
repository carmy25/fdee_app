import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fudiee/screens/home/widgets/fadein_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BuildImage extends ConsumerWidget {
  const BuildImage({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: SizedBox(
        width: 60,
        height: 60,
        child: AppFadeinImageView(
          image: AssetImage(image),
        ),
      ),
    );
  }
}
