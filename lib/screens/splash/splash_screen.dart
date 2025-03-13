import 'package:flutter/material.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudiee/main.data.dart';
import 'package:fudiee/models/user/user.model.dart';
import 'package:fudiee/screens/auth/auth.screen.dart';
import 'package:fudiee/screens/receipt/receipts.screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    _loadUser();
  }

  _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final remember = prefs.getBool('remember');
    if (remember != null && remember) {
      await ref.users
          .save(User(id: 1, token: prefs.getString('token')!), remote: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.users.watchOne(1, remote: false);
    return switch (userState) {
      DataState(:final model) =>
        model?.token == null ? AuthScreen() : ReceiptsScreen(),
    };
  }
}
