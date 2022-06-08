import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:online_recruitment/constants.dart';

void showdilog() {
  Get.dialog(
    const AlertDialog(
      backgroundColor: Colors.transparent,
      content: Center(
        child: SpinKitPouringHourGlassRefined(
          color: kPrimaryColor,
          size: 50,
        ),
      ),
    ),
    barrierDismissible: false,
  );
}

void closeDilog() {
  Get.back();
}
