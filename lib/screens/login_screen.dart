import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/register_screen.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:scoped_model/scoped_model.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _onSuccess() {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Usuario logado com sucesso!"),
        duration: Duration(seconds: 1),
        backgroundColor: Theme.of(context).primaryColor,
      ));
      Future.delayed(Duration(seconds: 1))
          .then((value) => {Navigator.of(context).pop()});
    }

    void _onFail() {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Erro ao Logar"),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ));
    }

    return Scaffold(
      key: _scaffoldKey,
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
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading)
            return Center(child: CircularProgressIndicator());
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                TextFormField(
                  controller: _emailController,
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
                    controller: _passwordController,
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
                      if (_formKey.currentState!.validate()) {}
                      model.signIn(
                          email: _emailController.text,
                          password: _passwordController.text,
                          onFail: _onFail,
                          onSuccess: _onSuccess);
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
          );
        },
      ),
    );
  }
}
