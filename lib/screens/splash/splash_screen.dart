import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudiee/constants/assets_constant.dart';
import 'package:fudiee/main.data.dart';
import 'package:fudiee/screens/auth/auth_screen.dart';
import 'package:fudiee/screens/home/home_screen.dart';
import 'package:get/get.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  static String routeName = '/splash';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(
        seconds: 2,
      ),
      () {
        final userState = ref.users.watchOne(1, remote: false);
        if (userState.isLoading) {
          return null;
        }
        if (userState.hasException) {
          return null;
        }

        if (userState.hasModel) {
          Get.offAllNamed(HomeScreen.routeName);
          return null;
        }
        Get.offAllNamed(AuthScreen.routeName);
        // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(repositoryInitializerProvider).when(
        error: (error, _) => Text(error.toString()),
        loading: () => const CircularProgressIndicator(),
        data: (_) {
          return Scaffold(
            body: Center(
              child: SizedBox(
                child: Image.asset(Assets.slashImg),
              ),
            ),
          );
        });
  }
}
