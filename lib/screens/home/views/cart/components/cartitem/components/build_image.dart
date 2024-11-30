import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fudiee/screens/home/widgets/fadein_image.dart';

class BuildImage extends StatelessWidget {
  const BuildImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
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
