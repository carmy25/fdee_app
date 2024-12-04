import 'package:flutter/material.dart';
import 'package:fudiee/screens/home/home_screen.dart';
import 'package:fudiee/screens/onboarding/onboarding_screen.dart';
import 'package:fudiee/themes/app_colors.dart';
import 'package:fudiee/widgets/textfield/app_textfield.dart';
import 'package:get/get.dart';

class SignIn extends StatefulWidget {
  const SignIn({
    Key? key,
  }) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(29, 0, 29, 0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const AppTextFormField(
              hint: "Ім'я",
            ),
            const SizedBox(height: 16),
            const AppTextFormField(
              hint: 'Пароль',
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
                        : primaryTextColor.withOpacity(0.7),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            AppButton(
              text: 'Ввійти',
              onPressed: () {
                Get.toNamed(HomeScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
