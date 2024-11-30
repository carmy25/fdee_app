import 'package:flutter/material.dart';
import 'package:fudiee/screens/home/views/cart/components/cartitem/components/price_and_cart_actions.dart';
import './components/build_image.dart';

class CartItem extends StatelessWidget {
  const CartItem(
      {Key? key,
      required this.index,
      required this.image,
      required this.title,
      required this.desc,
      required this.price,
      required this.rating,
      this.canDelete = true})
      : super(key: key);

  final int index;
  final String image;
  final String title;
  final String desc;
  final double price;
  final double rating;
  final bool canDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            BuildImage(image: image),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      child: Text(
                    title,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge,
                  )),
                ],
              ),
            ),
            if (canDelete)
              IconButton(
                icon: const Icon(Icons.close),
                tooltip: 'Видалити',
                onPressed: () {},
              ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BuildPriceAndCartActions(
              price: price,
              index: index,
            ),
            Text(
              '₴${price.round()}',
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        )
      ],
    );
  }
}
/*
BuildImage(image: image),
        const SizedBox(height: 10),
        SmoothIndicator(
          offset: index.toDouble(),
          count: 4,
          effect: const WormEffect(
            activeDotColor: Colors.pink,
            spacing: 12,
          ),
          size: const Size(8, 8),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              BuildPriceAndCartActions(
                price: price,
                index: index,
              ),
              SizedBox(height: 34.h),
              BuildDescriptionsAndRatings(
                title: title,
                desc: desc,
                rating: rating,
                index: index,
              ),
              SizedBox(height: 25.h),
              const AddYourMeal(),
              SizedBox(height: 35.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  minimumSize: const Size(double.infinity, 60),
                ),
                onPressed: () {},
                child: const Text(
                  'Place Order',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              SizedBox(height: 12.h),
            ],
          ),
        ),
*/
