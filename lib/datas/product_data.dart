// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData{
  late String category;
  late String id;
  late String title;
  late String description;
  late double price;
  late List images;
  late List sizes;

  ProductData.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.documentID;
    title = snapshot.data["title"];
    description = snapshot.data["description"];
    price = snapshot.data["price"] + 0.0;
    images = snapshot.data["images"];
    sizes = snapshot.data["sizes"];

  }

  Map<String, dynamic> toResumedMap() {
    return {
      "title": title,
      "description": description,
      "price": price
    };
  }
}