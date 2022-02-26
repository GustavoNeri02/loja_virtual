import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';

class DiscountCart extends StatelessWidget {
  const DiscountCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        title: Text("Cupom de Desconto",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[700]
          ),
        ),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Digite seu cupom",
              ),
              initialValue: CartModel.of(context).couponCode ?? "",
              onFieldSubmitted: (text){
                Firestore.instance
                    .collection("coupons")
                    .document(text).get().then(
                        (docsnap) => {
                          if(docsnap.data != null){
                            //cupom existe
                            CartModel.of(context).setCoupon(text, docsnap.data["percent"]),

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Desconto de ${docsnap.data["percent"]}% aplicado!"),
                                backgroundColor: Theme.of(context).primaryColor,
                              )
                            )
                          }else{
                            //cupom não existe
                            CartModel.of(context).setCoupon(null, 0),

                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Cupom não existente!"),
                                  backgroundColor: Colors.redAccent,
                                )
                            )
                          }
                        }
                    );
              },
            ),
          )
        ],
      ),
    );
  }
}
