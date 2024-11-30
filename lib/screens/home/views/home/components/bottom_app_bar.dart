import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudiee/themes/app_colors.dart';

class AppBottomBar extends StatelessWidget {
  const AppBottomBar({
    Key? key,
    required this.currentBottomIndex,
    required this.onTap,
  }) : super(key: key);

  final int currentBottomIndex;
  final ValueChanged onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: 80.h,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: primaryColor.withOpacity(0.4), width: 0.6),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: currentBottomIndex,
        landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
        type: BottomNavigationBarType.fixed,
        backgroundColor: scaffoldBgColor,
        fixedColor: primaryColor,
        unselectedIconTheme: const IconThemeData(size: 22),
        selectedIconTheme: IconThemeData(color: primaryColor, size: 24),
        selectedLabelStyle: TextStyle(color: primaryColor),
        unselectedItemColor: const Color(0xFF303030).withOpacity(0.7),
        selectedFontSize: 12.sp,
        unselectedFontSize: 11.sp,
        onTap: onTap,
        items: const [
          BottomNavigationBarItem(
            label: 'Головна',
            icon: Icon(Icons.home_outlined),
            activeIcon: BottomBarIndicator(icon: Icon(Icons.home)),
          ),
          BottomNavigationBarItem(
            label: 'Замовлення',
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: BottomBarIndicator(icon: Icon(Icons.shopping_cart)),
          ),
          BottomNavigationBarItem(
            label: 'Всі чеки',
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: BottomBarIndicator(icon: Icon(Icons.receipt_long)),
          ),
        ],
      ),
    );
  }
}

class BottomBarIndicator extends StatelessWidget {
  const BottomBarIndicator({
    Key? key,
    required this.icon,
  }) : super(key: key);
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        icon,
        const SizedBox(height: 1),
        Container(
          width: 20,
          height: 3,
          color: primaryColor,
        )
      ],
    );
  }
}
