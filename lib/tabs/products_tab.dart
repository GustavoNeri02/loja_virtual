// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/tiles/category_tile.dart';

class ProductsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          var dividedTiles = ListTile.divideTiles(
                  tiles: snapshot.data!.documents.map((doc) {
                    return CategoryTile(doc);
                  }).toList(),
                  color: Colors.grey[500])
              .toList();
          dividedTiles.sort((a,b) => b.toString().toLowerCase().compareTo(a.toString().toLowerCase()));
          return ListView(children: dividedTiles);
        }
      },
      future: Firestore.instance.collection("products").getDocuments(),
    );
  }
}
