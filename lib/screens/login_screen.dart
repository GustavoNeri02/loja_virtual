import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loja_virtual/screens/register_screen.dart';

class LoginScreen extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return RegisteScreen();
                },
              ));
            },
            child: Text(
              "CRIAR CONTA",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          )
        ],
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: "E-mail",
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (text) {
                if (text == null || text.isEmpty || !text.contains("@")) {
                  return "E-mail inválido!";
                }
              },
            ),
            SizedBox(height: 16),
            TextFormField(
                obscureText: true,
                decoration: InputDecoration(hintText: "Senha"),
                validator: (text) {
                  if (text == null || text.isEmpty || text.length < 6) {
                    return "Senha inválida!";
                  }
                }),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Esqueci minha senha",
                  textAlign: TextAlign.end,
                ),
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 44,
              child: ElevatedButton(
                onPressed: () {
                  if(_formkey.currentState!.validate()){

                  }
                },
                child: Text(
                  "Entrar",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
