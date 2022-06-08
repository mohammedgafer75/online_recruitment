import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_recruitment/Screens/Login/login_screen.dart';
import 'package:online_recruitment/Screens/Signup/signup_screen.dart';
import 'package:online_recruitment/Screens/Welcome/components/background.dart';
import 'package:online_recruitment/components/rounded_button.dart';
import 'package:online_recruitment/constants.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Background(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  "assets/icons/chat.svg",
                  height: size.height * 0.45,
                ),
                SizedBox(height: size.height * 0.05),
                RoundedButton(
                  text: "Login As Admin",
                  press: () {
                    Get.to(() => const LoginScreen());
                  },
                ),
                RoundedButton(
                  text: "Login  As User",
                  textColor: Colors.white,
                  press: () {
                    Get.to(() => const LoginScreen());
                  },
                ),
                RoundedButton(
                  text: "Login  As Financial Manager",
                  textColor: Colors.white,
                  press: () {
                    Get.to(() => const LoginScreen());
                  },
                ),
                RoundedButton(
                  text: "Login  As Registrar",
                  textColor: Colors.white,
                  press: () {
                    Get.to(() => const LoginScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
