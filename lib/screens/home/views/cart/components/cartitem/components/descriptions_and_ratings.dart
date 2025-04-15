import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildDescriptionsAndRatings extends ConsumerWidget {
  const BuildDescriptionsAndRatings({
    super.key,
    required this.title,
    required this.desc,
    required this.rating,
    required this.index,
  });

  final String title;
  final String desc;
  final double rating;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 11),
              SizedBox(
                width: 320,
                child: Text(
                  desc,
                  style: TextStyle(
                    fontSize: 12.sp,
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: RatingBar.builder(
            initialRating: rating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 2.w),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemSize: 20,
            onRatingUpdate: (rating) {},
          ),
        )
      ],
    );
  }
}
