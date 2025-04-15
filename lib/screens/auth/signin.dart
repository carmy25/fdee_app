import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudiee/main.data.dart';
import 'package:fudiee/models/user/user.model.dart';
import 'package:fudiee/routes/router.dart';
import 'package:fudiee/screens/receipt/receipts.screen.dart';
import 'package:fudiee/themes/app_colors.dart';
import 'package:fudiee/widgets/buttons/app_button.widget.dart';
import 'package:fudiee/widgets/textfield/app_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends ConsumerStatefulWidget {
  const SignIn({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
  bool rememberMe = false;
  final _usernameController = TextEditingController();
  final _passwdController = TextEditingController();

  void _showError() {
    if (!mounted) return;
    showErrorOverlay(context);
  }

  void showErrorOverlay(BuildContext context) {
    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (context) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(51),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: const Text(
              'не вдалось ввійти(невірний пароль або відсутній інтернет)',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);
    Future.delayed(const Duration(seconds: 3), () {
      entry.remove();
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _usernameController.dispose();
    _passwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(29, 0, 29, 0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            AppTextFormField(
              controller: _usernameController,
              hint: "Ім'я",
            ),
            const SizedBox(height: 16),
            AppTextFormField(
              hint: 'Пароль',
              controller: _passwdController,
              obscurable: true,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 28,
                  child: Checkbox(
                    splashRadius: 3,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    fillColor: WidgetStatePropertyAll(primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    value: rememberMe,
                    onChanged: (value) {
                      setState(() {
                        rememberMe = value!;
                      });
                    },
                  ),
                ),
                Text(
                  'Запамятати',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: rememberMe
                        ? primaryColor
                        : primaryTextColor.withAlpha(179),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            AppButtonWidget(
              text: 'Ввійти',
              onPressed: () async {
                final currentRouter = router;
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                try {
                  debugPrint('⌛ Attempting sign in...');
                  final user = await ref.users.jsonUserAdapter.signIn(
                    username: _usernameController.text,
                    password: _passwdController.text,
                  );
                  debugPrint('✅ Sign in response received: $user');

                  if (user == null) {
                    debugPrint('❌ User is null');
                    _showError();
                    return;
                  }

                  debugPrint('💾 Saving token...');
                  await prefs.setString('token', user.token);
                  await prefs.setBool('remember', rememberMe);

                  if (!mounted) return;
                  debugPrint('🚀 Navigating to receipts...');
                  currentRouter.go(ReceiptsScreen.routePath);
                } catch (e) {
                  debugPrint('❌ Error during sign in: $e');
                  _showError();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
