import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:online_recruitment/controller/main_controller.dart';
import 'dart:ui' as ui;

import 'package:online_recruitment/widgets/custom_textfield.dart';

class Reservtion extends StatefulWidget {
  const Reservtion({Key? key}) : super(key: key);

  @override
  State<Reservtion> createState() => _ReservtionState();
}

class _ReservtionState extends State<Reservtion> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('add Job'),
      ),
      resizeToAvoidBottomInset: false,
      body: form(context),
    );
  }
}

Widget form(context) {
  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;
  return GetBuilder<MainController>(
    init: MainController(),
    builder: (logic) {
      return Form(
        key: logic.formKey,
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
                // GetBuilder<MainController>(
                //   id: 'image',
                //   builder: (logic) {
                //     return GestureDetector(
                //       onTap: () {
                //         logic.imageSelect();
                //       },
                //       child: Container(
                //         height: height * 0.35,
                //         width: width * 0.65,
                //         decoration: BoxDecoration(
                //           color: Colors.black38,
                //           borderRadius: BorderRadius.circular(46),
                //         ),
                //         child: logic.image == null
                //             ? const Center(
                //                 child: Icon(Icons.add_a_photo_outlined))
                //             : Image.file(
                //                 File(logic.image!.path),
                //                 fit: BoxFit.cover,
                //               ),
                //       ),
                //     );
                //   },
                // ),
                Column(
                  children: [
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: logic.title,
                      validator: (value) {
                        return logic.validateAddress(value!);
                      },
                      lable: 'job title',
                      icon: const Icon(Icons.title),
                      input: TextInputType.text,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                        controller: logic.company,
                        validator: (value) {
                          return logic.validateAddress(value!);
                        },
                        lable: 'company name',
                        icon: const Icon(Icons.add_box),
                        input: TextInputType.text),
                    const SizedBox(height: 20),
                    CustomTextField(
                        controller: logic.desc,
                        validator: (value) {
                          return logic.validateAddress(value!);
                        },
                        lable: 'description',
                        icon: const Icon(Icons.description),
                        input: TextInputType.text),
                    const SizedBox(height: 20),
                    CustomTextField(
                        controller: logic.price,
                        validator: (value) {
                          return logic.validateAddress(value!);
                        },
                        lable: 'price',
                        icon: const Icon(Icons.attach_money),
                        input: TextInputType.number),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextButton(
                          onPressed: () async {
                            logic.addJob();
                          },
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.only(
                                top: height / 55,
                                bottom: height / 55,
                                left: width / 10,
                                right: width / 10)),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromRGBO(19, 26, 44, 1.0)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    side: const BorderSide(
                                        color:
                                            Color.fromRGBO(19, 26, 44, 1.0)))),
                          ),
                          child: const Text(
                            'save',
                            style: TextStyle(fontSize: 16),
                          )),
                    )
                  ],
                ),
              ],
            )),
      );
    },
  );
}
