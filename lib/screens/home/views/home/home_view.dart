import 'package:flutter/material.dart';
import 'package:fudiee/constants/data.dart';
import 'package:fudiee/screens/home/views/cart/components/cartitem/cart_item.dart';
import 'package:fudiee/screens/home/widgets/category_card.dart';

import 'components/header_section.dart';
import '../../widgets/popular_now_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String seletedCategory = 'Pizza';
  List<String> favorites = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
