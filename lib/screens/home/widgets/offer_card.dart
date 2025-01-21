import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudiee/themes/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OfferCard extends ConsumerWidget {
  const OfferCard({
    super.key,
    required this.percentOff,
    required this.offer,
    required this.onPressed,
    required this.image,
  });

  final double percentOff;
  final String offer;
  final VoidCallback onPressed;
  final String image;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 260.w,
      // width: 400,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: EdgeInsets.fromLTRB(18.w, 28.h, 12.w, 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5.h),
              Text(
                '${percentOff.toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 1),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.32,
                child: Text(
                  offer,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w300,
                    color: Colors.white.withValues(alpha: .9),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: Size(50.w, 40.h),
                  backgroundColor: const Color(0xFFD9D9D9),
                ),
                onPressed: onPressed,
                child: Text(
                  'Order Now!',
                  style: TextStyle(
                      color: primaryColor, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: SizedBox(
              height: 90.h,
              width: 90.w,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
