
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:scoped_model/scoped_model.dart';

class RegisteScreen extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    void _onSuccess() {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
        content: Text("Usuario criado com sucesso!"),
        duration: Duration(seconds: 1),
        backgroundColor: Theme.of(context).primaryColor,
      ));
      Future.delayed(Duration(seconds: 1)).then((value) => {
        Navigator.of(context).pop()
      });
    }

    void _onFail() {
      ScaffoldMessenger.of(_scaffoldKey.currentState!.context)
          .showSnackBar(SnackBar(
        content: Text("Usuario não criado!\nTente novamente!"),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ));

    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading) 
            return Center(child: CircularProgressIndicator(),);
          return Form(
            key: _formkey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: "Nome Completo",
                  ),
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  validator: (text) {
                    if (text == null || text.isEmpty || !text.contains(" ")) {
                      return "Nome completo inválido!";
                    }
                  },
                ),
                SizedBox(height: 16),
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
                  controller: _passController,
                  decoration: InputDecoration(
                    hintText: "Senha",
                  ),
                  obscureText: true,
                  validator: (text) {
                    if (text == null || text.isEmpty || text.length < 6) {
                      return "Senha inválida!";
                    }
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    hintText: "Endereço",
                  ),
                  keyboardType: TextInputType.streetAddress,
                  validator: (text) {
                    if (text == null || text.isEmpty || text.length < 10) {
                      return "Endereço inválido!";
                    }
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        Map<String, dynamic> userData = {
                          "name": _nameController.text,
                          "email": _emailController.text,
                          "adress": _addressController.text
                        };
                        model.signUp(
                            userdata: userData,
                            pass: _passController.text,
                            onSuccess: _onSuccess,
                            onFail: _onFail
                        );
                      }
                    },
                    child: Text(
                      "Criar Conta",
                      style: TextStyle(fontSize: 18),
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
