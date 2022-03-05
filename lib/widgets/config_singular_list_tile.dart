import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/login_screen.dart';

class ConfigSingularListTile extends StatelessWidget {
  const ConfigSingularListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _islogged = UserModel.of(context).isLoggedIn();

    return InkWell(
      borderRadius: BorderRadius.circular(30.0),
      splashColor: Colors.red,
      highlightColor: Colors.transparent,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 30, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTileTheme(
                  contentPadding: EdgeInsets.zero,
                  child: ListTile(
                    leading: CircleAvatar(
                        child: Icon(
                          _islogged? Icons.power_settings_new : Icons.login,
                          color: _islogged? Colors.redAccent : Colors.green,
                        ),
                        backgroundColor:
                        Colors.grey.withOpacity(0.08)),
                    title: Text(
                      _islogged ? "Deletar Conta" : "Clique para entrar!",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: _islogged? Colors.redAccent : Colors.black ,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: _islogged ?
          () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Wrap(children: [
                  Text("Deseja deletar sua conta"),
                  Text("permanentemente",
                    style: TextStyle(color: Colors.redAccent),),
                  Text("?")
                ]),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Digite as seguintes palavras:"),
                    Text("\"Deletar minha conta\"",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                actions: [
                  TextFormField(

                    decoration: InputDecoration(
                      labelText: "Deletar minha conta",
                      border: OutlineInputBorder(),
                    ),
                    onFieldSubmitted: (text){
                      if(text == "Deletar minha conta"){
                        UserModel.of(context).firebaseUser!.delete();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Sua conta foi Deletada!"),
                          backgroundColor: Theme.of(context).primaryColor,
                          duration: Duration(seconds: 2),
                        ));
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              ),
            );
          }
          : (){Navigator.of(context).push(MaterialPageRoute(
        builder:(context) => LoginScreen()));},
    );
  }
}
