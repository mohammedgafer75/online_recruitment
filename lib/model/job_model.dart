import 'package:cloud_firestore/cloud_firestore.dart';

class Jobs {
  String? id;
  String? company;
  String? title;
  String? description;
  int? price;

  Jobs({
    this.id,
    required this.company,
    required this.title,
    required this.description,
    required this.price,
  });

  Jobs.fromMap(DocumentSnapshot data) {
    id = data.id;
    company = data["company"];
    title = data["title"];
    description = data["description"];
    price = data["price"];
  }
}
