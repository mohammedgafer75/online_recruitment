import 'package:bottom_picker/bottom_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_recruitment/model/applications_model.dart';
import 'package:online_recruitment/model/job_model.dart';
import 'package:online_recruitment/widgets/loading.dart';
import 'dart:io';
import '../widgets/snackbar.dart';
import 'package:path/path.dart';

class MainController extends GetxController {
  late CollectionReference collectionReference;
  late CollectionReference collectionReference2;
  late CollectionReference collectionReference3;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  XFile? image;
  late String image_url;
  late TextEditingController title, desc, company, price, no;
  DateTime time = DateTime.now();
  auth.User? user;
  RxList<Jobs> jobs = RxList<Jobs>([]);
  RxList<Applications> applications = RxList<Applications>([]);

  @override
  void onInit() {
    user = FirebaseAuth.instance.currentUser;
    super.onInit();

    title = TextEditingController();
    desc = TextEditingController();
    company = TextEditingController();
    price = TextEditingController();
    no = TextEditingController();

    collectionReference = firebaseFirestore.collection("jobs");
    collectionReference2 = firebaseFirestore.collection("request");
    // collectionReference3 = firebaseFirestore.collection("applications");
    jobs.bindStream(getAllJobs());
    applications.bindStream(getAllRequests());
  }

  Stream<List<Jobs>> getAllJobs() => collectionReference
      .snapshots()
      .map((query) => query.docs.map((item) => Jobs.fromMap(item)).toList());
  Stream<List<Applications>> getAllRequests() =>
      collectionReference2.snapshots().map((query) =>
          query.docs.map((item) => Applications.fromMap(item)).toList());
  String? validateAddress(String value) {
    if (value.isEmpty) {
      return "please add all field";
    }
    return null;
  }

  void clear() {
    company.clear();
    title.clear();
    desc.clear();
  }

  late String _path;
  late Map<String, String> _paths;
  late String _extension;
  late FileType _pickType;
  bool _multiPick = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
// final List<StorageUploadTask> _tasks = <StorageUploadTask>[];
  File? file;
  int c = 0;
  void openFileExplorer() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf'],
          allowMultiple: false);
      if (result != null) {
        file = File(result.files.single.path!);
        c = 1;
      } else {
        // User canceled the picker
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
  }

  Future uploadImageToFirebase() async {
    String fileName = basename(file!.path);

    var _imageFile = File(file!.path);

    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('file/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

    await taskSnapshot.ref.getDownloadURL().then(
          (value) => image_url = value,
        );
  }

  void addJob() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      update();
      return;
    } else {
      showdilog();
      var re = <String, dynamic>{
        "title": title.text,
        "description": desc.text,
        "company": company.text,
        "price": int.tryParse(price.text),
      };
      collectionReference.doc().set(re).whenComplete(() {
        Get.back();
        showbar("Jobs Add", "Jobs Added", "Jobs Added", true);
        clear();
      }).catchError((error) {
        Get.back();
        showbar("Error", "Error", error.toString(), false);
      });
    }
  }

  void sendRequest(String title, String company) async {
    // final isValid = formKey.currentState!.validate();
    if (c == 0) {
      showbar('error', 'subtitle', 'please add your CV', false);
      return;
    } else {
      showdilog();
      await uploadImageToFirebase();
      var re = <String, dynamic>{
        "username": user!.displayName,
        "title": title,
        "company": company,
        "cv": image_url,
        "approve": 0
      };
      collectionReference2.doc().set(re).whenComplete(() {
        Get.back();
        showbar("Jobs Add", "Jobs Added", "Jobs Added", true);
        clear();
      }).catchError((error) {
        Get.back();
        showbar("Error", "Error", error.toString(), false);
      });
    }
  }
}
