import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:online_recruitment/constants.dart';
import 'package:online_recruitment/controller/auth_controller.dart';
import 'package:online_recruitment/controller/main_controller.dart';
import 'dart:ui' as ui;

import 'package:online_recruitment/widgets/custom_textfield.dart';

class AddAdmin extends StatefulWidget {
  const AddAdmin({Key? key}) : super(key: key);

  @override
  State<AddAdmin> createState() => _AddAdmin();
}

class _AddAdmin extends State<AddAdmin> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List<String> category = ["user", "registrar", "admin"];

  String currentCategorySelected = "user";

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('add admin or employee'),
        backgroundColor: kPrimaryColor,
      ),
      resizeToAvoidBottomInset: false,
      body: GetBuilder<AuthController>(
        init: AuthController(),
        builder: (logic) {
          return Form(
            key: logic.formKey2,
            child: Container(
                // height: height * 0.65,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(46),
                    topRight: Radius.circular(46),
                  ),
                ),
                child: ListView(
                  padding: EdgeInsets.only(top: 5),
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: logic.name,
                          validator: (value) {
                            return logic.validate(value!);
                          },
                          lable: 'user name',
                          icon: const Icon(Icons.title),
                          input: TextInputType.text,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                            controller: logic.email,
                            validator: (value) {
                              return logic.validateEmail(value!);
                            },
                            lable: 'email',
                            icon: const Icon(Icons.add_box),
                            input: TextInputType.text),
                        const SizedBox(height: 20),
                        CustomTextField(
                            controller: logic.password,
                            validator: (value) {
                              return logic.validatePassword(value!);
                            },
                            lable: 'password',
                            icon: const Icon(Icons.add_box),
                            input: TextInputType.text),
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
                                    icon: const Icon(Icons.person,
                                        color: Colors.black),
                                    iconEnabledColor: Colors.white,
                                    items: category
                                        .map((String dropDownStringItem) {
                                      return DropdownMenuItem<String>(
                                        value: dropDownStringItem,
                                        child: Text(dropDownStringItem),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValueSelected) {
                                      setState(() {
                                        currentCategorySelected =
                                            newValueSelected!;
                                      });
                                    },
                                    value: currentCategorySelected,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextButton(
                              onPressed: () async {
                                logic.number.text = '095571236';
                                logic.register(currentCategorySelected);
                              },
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.only(
                                        top: height / 55,
                                        bottom: height / 55,
                                        left: width / 10,
                                        right: width / 10)),
                                backgroundColor:
                                    MaterialStateProperty.all(kPrimaryColor),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        side: const BorderSide(
                                            color: kPrimaryColor))),
                              ),
                              child: const Text(
                                'save',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              )),
                        )
                      ],
                    ),
                  ],
                )),
          );
        },
      ),
    );
  }
}

// Widget form(context) {
//   List<String> category = ["user", "registrar"];

//   String currentCategorySelected = "user";
//   var height = MediaQuery.of(context).size.height;
//   var width = MediaQuery.of(context).size.width;
//   return GetBuilder<AuthController>(
//     init: AuthController(),
//     builder: (logic) {
//       return Form(
//         key: logic.formKey,
//         child: Container(
//             // height: height * 0.65,
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(46),
//                 topRight: Radius.circular(46),
//               ),
//             ),
//             child: ListView(
//               padding: EdgeInsets.only(top: 5),
//               // crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Column(
//                   children: [
//                     const SizedBox(height: 20),
//                     CustomTextField(
//                       controller: logic.name,
//                       validator: (value) {
//                         return logic.validate(value!);
//                       },
//                       lable: 'user name',
//                       icon: const Icon(Icons.title),
//                       input: TextInputType.text,
//                     ),
//                     const SizedBox(height: 20),
//                     CustomTextField(
//                         controller: logic.email,
//                         validator: (value) {
//                           return logic.validateEmail(value!);
//                         },
//                         lable: 'password',
//                         icon: const Icon(Icons.add_box),
//                         input: TextInputType.text),
//                         Padding(
//                   padding: const EdgeInsets.only(left: 40.0, right: 40),
//                   child: Row(
//                     children: [
//                       const Expanded(
//                           child: Text(
//                         "Account type :",
//                         style: TextStyle(color: Colors.black),
//                       )),
//                       Expanded(
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           child: DropdownButton(
//                             icon: const Icon(Icons.person, color: Colors.black),
//                             iconEnabledColor: Colors.white,
//                             items: category.map((String dropDownStringItem) {
//                               return DropdownMenuItem<String>(
//                                 value: dropDownStringItem,
//                                 child: Text(dropDownStringItem),
//                               );
//                             }).toList(),
//                             onChanged: (String? newValueSelected) {
//                               setState(() {
//                                 currentCategorySelected = newValueSelected!;
//                               });
//                             },
//                             value: currentCategorySelected,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                     Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: TextButton(
//                           onPressed: () async {
//                             logic.register();
//                           },
//                           style: ButtonStyle(
//                             padding: MaterialStateProperty.all(EdgeInsets.only(
//                                 top: height / 55,
//                                 bottom: height / 55,
//                                 left: width / 10,
//                                 right: width / 10)),
//                             backgroundColor: MaterialStateProperty.all(
//                                 const Color.fromRGBO(19, 26, 44, 1.0)),
//                             shape: MaterialStateProperty.all<
//                                     RoundedRectangleBorder>(
//                                 RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(13),
//                                     side: const BorderSide(
//                                         color:
//                                             Color.fromRGBO(19, 26, 44, 1.0)))),
//                           ),
//                           child: const Text(
//                             'save',
//                             style: TextStyle(fontSize: 16),
//                           )),
//                     )
//                   ],
//                 ),
//               ],
//             )),
//       );
//     },
//   );
// }
