import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudiee/constants/assets_constant.dart';
import 'package:fudiee/screens/auth/signin.dart';
import 'package:fudiee/themes/app_colors.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  static String routeName = '/auth';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var currentTab = 0;

  @override
  void initState() {
    _tabController = TabController(
      length: 1,
      vsync: this,
    );

    _tabController.addListener(() {
      setState(() => currentTab = _tabController.index);
    });

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          height: height,
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: height * 0.45,
                child: Image.asset(
                  Assets.authBg,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  // padding: const EdgeInsets.fromLTRB(29, 25, 29, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(22.w, 25.h, 29.w, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _AuthTabs(
                              text: 'Вхід',
                              active: currentTab == 0,
                              onTap: () {
                                _tabController.animateTo(0);
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          physics: const BouncingScrollPhysics(),
                          children: const [
                            SignIn(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _AuthTabs extends ConsumerWidget {
  const _AuthTabs({
    required this.text,
    required this.active,
    required this.onTap,
  });

  final String text;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Ink(
        padding: const EdgeInsets.all(8),
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: active ? primaryTextColor : greyColor,
                    ),
              ),
              const SizedBox(height: 2),
              AnimatedOpacity(
                opacity: active ? 1 : 0,
                duration: const Duration(milliseconds: 400),
                child: Container(
                  width: 42,
                  height: 3,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
