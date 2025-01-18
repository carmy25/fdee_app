import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudiee/constants/data.dart';
import 'package:fudiee/screens/home/views/cart/components/cartitem/cart_item.dart';
import 'package:fudiee/screens/home/views/home/components/header_section.dart';
import 'package:fudiee/screens/home/widgets/category_card.dart';
import 'package:fudiee/screens/home/widgets/popular_now_card.dart';
import 'package:fudiee/themes/app_colors.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});
  static String routePath = '/cart';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  String seletedCategory = 'Pizza';
  List<String> favorites = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: scaffoldBgColor,
        title: Text(
          'Замовлення',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 35),
          HeaderSection(
            onPressed: () {},
            title: 'Популярні',
          ),

          SizedBox(
            height: 170,
            child: ListView.separated(
              shrinkWrap: true,
              clipBehavior: Clip.none,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              separatorBuilder: (context, index) => const SizedBox(width: 23),
              itemBuilder: (_, index) {
                final food = popularData[index];
                return PopularNowCard(
                  title: food.title,
                  deliveryTime: food.deliveryTime,
                  price: food.price,
                  image: food.image,
                  onPressed: () {},
                  favorite: favorites.contains(food.title),
                  onLike: (value) {
                    value && !favorites.contains(food.title)
                        ? setState(() => favorites.add(food.title))
                        : setState(() => favorites.remove(food.title));
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 25),
          HeaderSection(
            onPressed: () {},
            title: 'Категорії',
          ),

          // categories section
          SizedBox(
            height: 115,
            child: ListView.separated(
              clipBehavior: Clip.none,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              separatorBuilder: (context, index) => const SizedBox(width: 23),
              itemBuilder: (context, index) {
                final category = categoryData[index];
                return CategoryCard(
                  category: category.category,
                  image: category.image,
                  onSelected: (value) {
                    setState(() {
                      if (value) {
                        seletedCategory = category.category;
                      }
                    });
                  },
                  selected: seletedCategory == category.category ? true : false,
                );
              },
            ),
          ),

          const SizedBox(
            height: 20,
          ),
          HeaderSection(
            onPressed: () {},
            title: 'Продукти',
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: ListView.separated(
                  separatorBuilder: (_, __) => const SizedBox(
                    height: 10,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  restorationId: 'cart_view',
                  shrinkWrap: true,
                  itemCount: cartData.length,
                  itemBuilder: (context, index) {
                    final cart = cartData[index];
                    return CartItem(
                      index: index,
                      title: cart.title,
                      desc: cart.desc,
                      image: cart.image,
                      price: cart.price,
                      rating: cart.rating,
                      canDelete: false,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
