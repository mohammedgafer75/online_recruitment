import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String? id;
  String? name;
  String? email;
  int? number;

  Users({
    this.id,
    required this.name,
    required this.email,
    required this.number,
  });

  Users.fromMap(DocumentSnapshot data) {
    id = data.id;
    name = data["name"];
    email = data["email"];
    number = data["number"];
  }
}
