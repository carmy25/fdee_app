import 'package:flutter/material.dart';

class AppCircleImage extends StatelessWidget {
  const AppCircleImage({
    super.key,
    required this.image,
    this.isImageFromInternet = false,
  });

  final String image;
  final bool isImageFromInternet;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: isImageFromInternet
          ? Image.network(image, height: 60, width: 60, fit: BoxFit.cover)
          : Image.asset(image, height: 60, width: 60, fit: BoxFit.cover),
    );
  }
}
