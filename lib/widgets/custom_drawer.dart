import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/login_screen.dart';
import 'package:loja_virtual/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  const CustomDrawer(this.pageController);

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
                      top: 0,
                      bottom: 0,
                      child: Text(
                        "Flutter's\nclothing",
                        style: TextStyle(
                            fontSize: 34, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        child: ScopedModelDescendant<UserModel>(
                            builder: (context, child, model) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                model.isLoggedIn()
                                    ? "Olá ${model.userData["name"]}!"
                                    : "Olá Visitante!",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                onTap: () {
                                  model.isLoggedIn()
                                      ? model.signOut()
                                      : Navigator.push(context,
                                          MaterialPageRoute(
                                          builder: (context) {
                                            return LoginScreen();
                                          },
                                        ));
                                },
                                child: Text(
                                  model.isLoggedIn()
                                      ? "Sair..."
                                      : "Entre ou cadastre-se aqui",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                            ],
                          );
                        })),
                  ],
                ),
              ),
              Divider(
                endIndent: 32,
              ),
              DrawerTile(Icons.home, "Início", pageController, 0),
              DrawerTile(Icons.list, "Produtos", pageController, 1),
              DrawerTile(
                  Icons.playlist_add_check, "Meus pedidos", pageController, 2),
              DrawerTile(
                  Icons.location_on, "Encontre uma loja", pageController, 3),
            ],
          )
        ],
      ),
    );
  }
}
