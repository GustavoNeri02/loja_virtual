// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/datas/product_data.dart';

class CartProduct{
  late String cartId;
  late String category;
  late String productId;
  late int quantity;
  late String size;

  late ProductData? productData;

  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot documentSnapshot) {
    cartId = documentSnapshot.documentID;
    category = documentSnapshot.data["category"];
    productId = documentSnapshot.data["productId"];
    quantity = documentSnapshot.data["quantity"];
    size = documentSnapshot.data["size"];
    productData = null;
  }

  Map<String, dynamic> toMap(){
    return{
      "size" : size,
      "category" : category,
      "productId" : productId,
      "quantity" : quantity,
      //"product" : productData.toResumedMap()
    };
  }
}