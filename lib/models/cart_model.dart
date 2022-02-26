import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel user;

  List<CartProduct> products = [];

  bool isLoading = false;

  CartModel(this.user){
    if(user.isLoggedIn()){
      _loadCartItems();
    }
  }

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);
    Firestore.instance
        .collection("Users")
        .document(user.firebaseUser!.uid)
        .collection("cart")
        .add(cartProduct.toMap())
        .then((doc) {
      cartProduct.cartId = doc.documentID;
    });
    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) {
    products.remove(cartProduct);
    Firestore.instance
        .collection("Users")
        .document(user.firebaseUser!.uid)
        .collection("cart")
        .document(cartProduct.cartId)
        .delete();
    notifyListeners();
  }

  void decProduct(CartProduct cartProduct){
    cartProduct.quantity--;
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser!.uid)
        .collection("cart")
        .document(cartProduct.cartId)
        .updateData(cartProduct.toMap());

    notifyListeners();
  }

  void incProduct(CartProduct cartProduct){
    cartProduct.quantity++;
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser!.uid)
        .collection("cart")
        .document(cartProduct.cartId)
        .updateData(cartProduct.toMap());

    notifyListeners();
  }

  void _loadCartItems() async {
    QuerySnapshot query = await Firestore.instance
        .collection("users")
        .document(user.firebaseUser!.uid)
        .collection("cart").getDocuments();

    products = query.documents.map((e) => CartProduct.fromDocument(e)).toList();
    notifyListeners();
  }

}
