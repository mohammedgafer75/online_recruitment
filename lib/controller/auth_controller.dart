import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_recruitment/Screens/Login/login_screen.dart';
import 'package:online_recruitment/Screens/Welcome/welcome_screen.dart';
import 'package:online_recruitment/Screens/jobs.dart';
import 'package:online_recruitment/Screens/master.dart';
import 'package:online_recruitment/admin_page.dart';
import 'package:online_recruitment/components/rounded_button.dart';
import 'package:online_recruitment/manager_page.dart';
import 'package:online_recruitment/model/user_model.dart';
import 'package:online_recruitment/registrar.dart';
import 'package:online_recruitment/widgets/loading.dart';
import 'package:online_recruitment/widgets/snackbar.dart';

class AuthController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  late TextEditingController email,
      name,
      password,
      Rpassword,
      repassword,
      number;
  RxList<Users> users = RxList<Users>([]);
  bool ob = false;
  bool obscureTextLogin = true;
  bool obscureTextSignup = true;
  bool obscureTextSignupConfirm = true;
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  static FirebaseAuth auth = FirebaseAuth.instance;
  late Widget route;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;
  @override
  void onReady() {
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
    super.onReady();
  }

  @override
  void onInit() {
    collectionReference = firebaseFirestore.collection("user");
    email = TextEditingController();
    password = TextEditingController();
    Rpassword = TextEditingController();
    repassword = TextEditingController();
    number = TextEditingController();
    name = TextEditingController();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    users.bindStream(getAllUser());
    ever(_user, _initialScreen);
    super.onInit();
  }
// دالة جلب المستخدمين من الداتا بيز
  Stream<List<Users>> getAllUser() => collectionReference
      .snapshots()
      .map((query) => query.docs.map((item) => Users.fromMap(item)).toList());
  String? get user_ch => _user.value!.email;
  _initialScreen(User? user) {
    if (user == null) {
      route = const LoginScreen();
    } else {
      // route = const Master();
    }
  }

  toggleLogin() {
    obscureTextLogin = !obscureTextLogin;

    update();
  }

  toggleSignup() {
    obscureTextSignup = !obscureTextSignup;
    update();
  }

  toggleSignupConfirm() {
    obscureTextSignupConfirm = !obscureTextSignupConfirm;
    update();
  }
// دالة التاكد  من ادخال الاسم
  String? validate(String value) {
    if (value.isEmpty) {
      return "please enter your name";
    }

    return null;
  }

  String? validateNumber(String value) {
    if (value.isEmpty) {
      return "please enter your Phone";
    }
    if (value.length < 10) {
      return "Phone length must be more than 10";
    }

    return null;
  }

  String? validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    if (value.isEmpty) {
      return "please enter your email";
    }

    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "please enter your password";
    }
    if (value.length < 6) {
      return "password length must be more than 6 ";
    }
    return null;
  }

  String? validateRePassword(String value) {
    if (value.isEmpty) {
      return "please enter your password";
    }
    if (value.length < 6) {
      return "password length must be more than 6 ";
    }
    if (password.text != value) {
      return "Password not matched ";
    }
    return null;
  }

  changeOb() {
    ob = !ob;
    update(['password']);
  }
// دالة تسجيل الخروج
  void signOut() async {
    Get.dialog(AlertDialog(
      content: const Text('Are you are sure to log out ????'),
      actions: [
        RoundedButton(
          press: () async {
            await auth
                .signOut()
                .then((value) => Get.offAll(() => const LoginScreen()));
          },
          text: 'YES',
        ),
        RoundedButton(
          press: () {
            Get.back();
          },
          text: 'Back',
        ),
      ],
    ));
  }
// دالة حذف العميل
  void deleteCustomer(String id) {
    Get.dialog(AlertDialog(
      content: const Text('Delete user'),
      actions: [
        TextButton(
            onPressed: () async {
              try {
                showdilog();
                FirebaseFirestore.instance.collection('user').doc(id).delete();
                Get.back();
                Get.back();
                showbar('delete customer', '', 'customer deleted', true);
              } catch (e) {
                showbar('delete customer', '', e.toString(), false);
                Get.back();
              }
            },
            child: const Text('delete')),
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('back'))
      ],
    ));
  }
// دالة انشاء الحساب
  void register(String table) async {
    if (formKey2.currentState!.validate()) {
      try {
        // SmartDialog.showLoading();
        showdilog();
        final credential = await auth.createUserWithEmailAndPassword(
            email: email.text, password: password.text);
        credential.user!.updateDisplayName(name.text);
        await credential.user!.reload();
        if (table == 'admin') {
          await FirebaseFirestore.instance
              .collection('admin')
              .doc(credential.user!.uid)
              .set({
            'name': name.text,
            'email': email.text,
            'number': int.tryParse(number.text),
            'uid': credential.user!.uid,
            'approve': 1
          });
          Get.back();
          email.clear();
          password.clear();
          showbar("About User", "User message", "User Created!!", true);
        } else {
          await FirebaseFirestore.instance
              .collection('user')
              .doc(credential.user!.uid)
              .set({
            'name': name.text,
            'email': email.text,
            'type': table,
            'number': int.tryParse(number.text),
            'uid': credential.user!.uid,
            'approve': 1
          });
          Get.back();
          email.clear();
          password.clear();
          showbar("About User", "User message", "User Created!!", true);
        }
      } on FirebaseAuthException catch (e) {
        Get.back();
        showbar("About User", "User message", e.toString(), false);
      }
    }
  }
// دالة تسجيل الدخول
  void login() async {
    if (formKey.currentState!.validate()) {
      try {
        showdilog();
        await auth.signInWithEmailAndPassword(
            email: email.text, password: password.text);
        var ch = await FirebaseFirestore.instance.collection('user').get();
        int approve = 0;
        var ch2 = await FirebaseFirestore.instance.collection('admin').get();
        int approve2 = 0;
        for (var element in ch.docs) {
          if (element['email'] == email.text && element['type'] == 'user') {
            approve = 1;
          }
          if (element['email'] == email.text &&
              element['type'] == 'registrar' &&
              element['approve'] == 1) {
            approve = 2;
          }
        }
        for (var element in ch2.docs) {
          if (element['approve'] == 1 && element['email'] == email.text) {
            approve2 = 1;
          }
        }
        if (approve == 1) {
          email.clear();
          password.clear();
          Get.back();
          Get.offAll(() => Master());
        }
        if (approve == 2) {
          email.clear();
          password.clear();
          Get.back();
          Get.offAll(() => const RegistrarPage());
        }
        if (approve2 == 1) {
          email.clear();
          password.clear();
          Get.back();
          Get.offAll(() => AdminPage());
        }
        if (approve != 1 && approve != 2 && approve2 != 1) {
          Get.back();
          showbar(
              "About Login", "Login message", 'ليس لديك صلاحية للدخول', false);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.back();
          showbar("About Login", "Login message", 'كلمة السر ضعيفة', false);
        }
        if (e.code == 'email-already-in-use') {
          Get.back();
          showbar("About Login", "Login message", 'الايميل محجوز مسبقا', false);
        }
        if (e.code == 'user-not-found') {
          Get.back();
          showbar("About Login", "Login message", ' اليوزر غير موجود', false);
        }
        if (e.code == 'wrong-password') {
          Get.back();
          showbar(
              "About Login", "Login message", ' كلمة السر غير صحيحة', false);
        } else {
          // Get.back();
          showbar("About Login", "Login message", e.toString(), false);
        }
      }
    }
  }
}
