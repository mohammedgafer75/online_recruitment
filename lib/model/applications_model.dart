import 'package:cloud_firestore/cloud_firestore.dart';
// نموذج الطلب
class Applications {
  String? id;
  String? company;
  String? title;
  String? cv;
  int? approve;

  Applications({
    this.id,
    required this.company,
    required this.title,
    required this.cv,
    required this.approve,
  });

  Applications.fromMap(DocumentSnapshot data) {
    id = data.id;
    company = data["company"];
    title = data["title"];
    cv = data["cv"];
    approve = data["approve"];
  }
}
