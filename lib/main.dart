import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp());
}

final Color primary = Color.fromARGB(255, 4, 125, 141);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return ScopedModel<CartModel>(
            model: CartModel(model),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Loja de Roupas Flutter',
              theme: ThemeData(
                appBarTheme: AppBarTheme(color: primary),
                elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      primary: primary
                    )),
                primarySwatch: Colors.blue,
                primaryColor: primary),
              home: HomeScreen(),
            ),
          );
        },
      ),
    );
  }
}
