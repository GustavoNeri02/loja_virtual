import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceTile extends StatelessWidget {

  final DocumentSnapshot documentSnapshot;

  PlaceTile(this.documentSnapshot);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 100,
            child: Image.network(documentSnapshot.data["image"], fit: BoxFit.cover,),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(documentSnapshot.data["title"],
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17
                  ),
                ),
                Text(documentSnapshot.data["adress"],
                  textAlign: TextAlign.start,

                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: Text("Ver no mapa"),
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                onPressed: (){
                  launch(documentSnapshot.data["local"]);
                },
              ),
              TextButton(
                child: Text("Ligar"),
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                onPressed: (){
                  launch("tel:${documentSnapshot.data["phone"]}");
                },
              ),
            ],
          )

        ],
      ),
    );
  }
}
