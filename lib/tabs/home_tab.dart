import 'dart:ui';

// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:transparent_image/transparent_image.dart';


class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _buildBodyBack() => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 211, 118, 130),
                Color.fromARGB(255, 253, 181, 168),
              ],
            ),
          ),
        );
    return Stack(
      children: [
        _buildBodyBack(),
        CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Novidades!"),
                centerTitle: true,
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: Firestore.instance
                  .collection("home")
                  .orderBy("pos")
                  .getDocuments(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SliverToBoxAdapter(
                    child: Container(
                      width: 200,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    ),
                  );
                } else {
                  return SliverStaggeredGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                    staggeredTiles: snapshot.data!.documents.map((doc) {
                      return StaggeredTile.count(doc.data["x"], doc.data["y"]);
                    }).toList(),
                    children: snapshot.data!.documents.map((doc) {
                      return FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: doc.data["image"],
                        fit: BoxFit.cover,
                      );
                    }).toList(),
                  );
                }
              },
            )
          ],
        ),
      ],
    );
  }
}
