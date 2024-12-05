import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fudiee/constants/data.dart';
import 'package:fudiee/screens/home/views/cart/components/cartitem/components/cart_action_buttons.dart';
import 'package:fudiee/themes/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BuildPriceAndCartActions extends ConsumerWidget {
  const BuildPriceAndCartActions({
    super.key,
    required this.price,
    required this.index,
  });

  final double price;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 10,
            ),
            Text(
              '₴${price.round()}',
              style: TextStyle(
                fontSize: 23,
                color: pinkColor,
              ),
            ),
            CartActionButtons(
              itemCount: cartData[index].itemCount,
              onAdd: () {},
              onReduce: () {},
            ),
          ],
        ),
      ],
    );
  }
}
