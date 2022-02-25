import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu Carrinho"),
        actions: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 8),
            child: ScopedModelDescendant<CartModel>(
                builder: (context, child, model) {
              int p = model.products.length;
              return Text(
                "$p ${p == 1 ? "ITEM" : "ITENS"}",
                style: TextStyle(fontSize: 17),
              );
            }),
          )
        ],
      ),
    );
  }
}
