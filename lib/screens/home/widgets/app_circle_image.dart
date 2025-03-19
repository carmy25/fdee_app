import 'package:cached_network_image/cached_network_image.dart';
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
            ? CachedNetworkImage(
              imageUrl: image,
              height: 60,
              width: 60,
              fit: BoxFit.cover,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            )
          : Image.asset(image, height: 60, width: 60, fit: BoxFit.cover),
    );
  }
}
