import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                    fontSize: 12,
                    color: rememberMe
                        ? primaryColor
                        : primaryTextColor.withValues(alpha: .7),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            AppButtonWidget(
              text: 'Ввійти',
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(context);
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                try {
                  final user = await ref.users.jsonUserAdapter.signIn(
                    username: _usernameController.text,
                    password: _passwdController.text,
                  );
                  if (user?.token != null) {
                    await prefs.setString('token', user!.token);
                    await prefs.setBool('remember', rememberMe);
                    router.go(ReceiptsScreen.routePath);
                    return;
                  }
                } catch (e) {
                  debugPrint('❌ $e');
                } finally {
                  messenger.showSnackBar(
                    const SnackBar(
                      content: Text(
                          'не вдалось ввійти(невірний пароль або відсутній інтернет)'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
