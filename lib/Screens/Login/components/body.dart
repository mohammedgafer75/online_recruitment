import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_recruitment/Screens/Login/components/background.dart';
import 'package:online_recruitment/Screens/Signup/signup_screen.dart';
import 'package:online_recruitment/components/already_have_an_account_acheck.dart';
import 'package:online_recruitment/components/rounded_button.dart';
import 'package:online_recruitment/components/rounded_input_field.dart';
import 'package:online_recruitment/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:online_recruitment/constants.dart';

import '../../../controller/auth_controller.dart';

class Body extends StatelessWidget {
  Body({
    Key? key,
  }) : super(key: key);
  final AuthController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          "LOGIN".toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Background(
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: size.height * 0.03),
                SvgPicture.asset(
                  "assets/icons/login.svg",
                  height: size.height * 0.35,
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  hintText: "Your Email",
                  controller: controller.email,
                  icon: Icons.email,
                  validator: (value) {
                    return controller.validateEmail(value!);
                  },
                ),
                RoundedPasswordField(
                  hintText: "Your Password",
                  controller: controller.password,
                  validator: (val) {
                    return controller.validatePassword(val!);
                  },
                ),
                RoundedButton(
                  text: "LOGIN",
                  press: () {
                    controller.login();
                  },
                ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  press: () {
                    controller.email.clear();
                    controller.password.clear();
                    Get.to(() => SignUpScreen());
                  },
                ),
                SizedBox(height: size.height * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
