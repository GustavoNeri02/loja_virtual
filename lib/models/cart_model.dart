import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel user;

  List<CartProduct> products = [];

  String? couponCode;
  int discountPercentage = 0;

  bool isLoading = false;

  CartModel(this.user){
    if(user.isLoggedIn()){
      _loadCartItems();
    }
  }

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct) {

    //Adicionar quantidade se produto ja contido no carrinho
    bool rep = false;
    products.forEach(
      (prod) => {
        if(prod.productId == cartProduct.productId && prod.size == cartProduct.size){
          incProduct(prod),
          rep = true,
        }
      }
    );

    //Adicionar novo produto ao carrinho
    if(!rep){
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
        .collection("Users")
        .document(user.firebaseUser!.uid)
        .collection("cart")
        .document(cartProduct.cartId)
        .updateData(cartProduct.toMap());

    notifyListeners();
  }

  void incProduct(CartProduct cartProduct){
    cartProduct.quantity++;
    Firestore.instance
        .collection("Users")
        .document(user.firebaseUser!.uid)
        .collection("cart")
        .document(cartProduct.cartId)
        .updateData(cartProduct.toMap());

    notifyListeners();
  }

  void setCoupon(String? couponCode, int discountPercentage){
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }

  void updatePrices(){
    notifyListeners();
  }

  double getProductsPrice(){
    double price = 0;
    for(CartProduct c in products){
      if(c.productData != null){
        price += c.quantity * c.productData.price;
      }
    }
    return price;
  }

  double getDiscount(){
    return getProductsPrice() * discountPercentage/100;
  }

  double getShipPrice(){
    return 9.99;
  }





  void _loadCartItems() async {

    QuerySnapshot query = await Firestore.instance
        .collection("Users")
        .document(user.firebaseUser!.uid)
        .collection("cart").getDocuments();

    products = query.documents.map((doc) => CartProduct.fromDocument(doc)).toList();

    notifyListeners();
  }

}
