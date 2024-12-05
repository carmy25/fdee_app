import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fudiee/constants/data.dart';
import 'package:fudiee/screens/home/views/cart/components/cartitem/cart_item.dart';
import 'package:fudiee/themes/app_colors.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartView extends ConsumerWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: ListView.separated(
                  separatorBuilder: (_, __) => const SizedBox(
                    height: 13,
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
                    );
                  },
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll<Color>(Colors.green)),
                      onPressed: () {},
                      child: const Row(
                        children: [
                          Text(
                            'Закрити чек ₴356',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ToggleSwitch(
                      initialLabelIndex: 0,
                      cornerRadius: 20.0,
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      totalSwitches: 2,
                      icons: const [
                        FontAwesomeIcons.creditCard,
                        FontAwesomeIcons.moneyBill,
                      ],
                      iconSize: 30.0,
                      borderWidth: 2.0,
                      borderColor: const [Colors.blueGrey],
                      activeBgColors: const [
                        [Colors.blue],
                        [Colors.pink],
                      ],
                      onToggle: (index) {
                        if (kDebugMode) {
                          print('switched to: $index');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
