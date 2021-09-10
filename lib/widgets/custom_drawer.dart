
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 253, 181, 168),
          ],
        ),
      ),
    );

    return Drawer(
      child: Stack(
          children: [
            _buildDrawerBack(),
            ListView(
              padding: EdgeInsets.only(left: 32, top: 16),
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  padding: EdgeInsets.fromLTRB(0, 16, 16, 8),
                  height: 170,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 8,
                        bottom: 0,
                        child: Text(
                          "Flutter's\nclothing",
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
      ),
    );
  }
}
