// صفحة انشاء حساب جديد 

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_recruitment/Screens/Signup/components/background.dart';
import 'package:online_recruitment/components/rounded_button.dart';
import 'package:online_recruitment/components/rounded_input_field.dart';
import 'package:online_recruitment/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:online_recruitment/constants.dart';
import 'package:online_recruitment/controller/auth_controller.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AuthController controller = Get.find();

  List<String> category = ["user", "registrar"];

  String currentCategorySelected = "user";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
          "SIGNUP",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Background(
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: size.height * 0.03),
                SvgPicture.asset(
                  "assets/icons/signup.svg",
                  height: size.height * 0.35,
                ),
                RoundedInputField(
                  hintText: "Your Name",
                  controller: controller.name,
                  icon: Icons.person,
                  validator: (value) {
                    return controller.validate(value!);
                  },
                ),
                RoundedInputField(
                  hintText: "Your Email",
                  controller: controller.email,
                  icon: Icons.email,
                  validator: (value) {
                    return controller.validateEmail(value!);
                  },
                ),
                RoundedInputField(
                  hintText: "Your Phone",
                  controller: controller.number,
                  icon: Icons.call,
                  validator: (value) {
                    return controller.validateNumber(value!);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 40),
                  child: Row(
                    children: [
                      const Expanded(
                          child: Text(
                        "Account type :",
                        style: TextStyle(color: Colors.black),
                      )),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: DropdownButton(
                            icon: const Icon(Icons.person, color: Colors.black),
                            iconEnabledColor: Colors.white,
                            items: category.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem),
                              );
                            }).toList(),
                            onChanged: (String? newValueSelected) {
                              setState(() {
                                currentCategorySelected = newValueSelected!;
                              });
                            },
                            value: currentCategorySelected,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                RoundedPasswordField(
                  hintText: "Your Password",
                  controller: controller.password,
                  validator: (value) {
                    return controller.validatePassword(value!);
                  },
                ),
                RoundedPasswordField(
                  hintText: "Re Type Password",
                  controller: controller.repassword,
                  validator: (value) {
                    return controller.validateRePassword(value!);
                  },
                ),
                RoundedButton(
                  text: "SIGNUP",
                  press: () {
                    controller.register(currentCategorySelected);
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
