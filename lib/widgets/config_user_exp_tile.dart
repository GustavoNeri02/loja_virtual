import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class ConfigUserExpTile extends StatelessWidget {
  IconData icon;
  String title;

  ConfigUserExpTile(this.icon, this.title);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model) {
        String? _valueText;
        Color _iconColor = model.isLoggedIn()? Theme.of(context).primaryColor: Colors.grey;
        Color _textColor = model.isLoggedIn()? Colors.black: Colors.grey;
        bool _block = !model.isLoggedIn();
        Function(String)? _function;


        switch (title) {
          case "Nome":
            _valueText = model.userData["name"];
            _function = (newName) {
              Firestore.instance.collection("Users").document(
                UserModel.of(context).firebaseUser!.uid.toString()
              ).updateData({"name": newName});
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Nome Atualizado!"),
                backgroundColor: Theme.of(context).primaryColor,
                duration: Duration(seconds: 2),
              ));
            };
            break;

          case "Telefone":
            if (model.userData["phone"] == null) {
              _valueText = "";
            } else {
              _valueText = model.userData["phone"];
            }
            _function = (newPhone) {
              Firestore.instance.collection("Users").document(
                  UserModel.of(context).firebaseUser!.uid.toString()
              ).updateData({"phone": newPhone});
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Telefone Atualizado!"),
                backgroundColor: Theme.of(context).primaryColor,
                duration: Duration(seconds: 2),
              ));
            };

            break;

          case "E-mail":
            _valueText = model.userData["email"];
            break;

          case "Endereço":
            _valueText = model.userData["adress"];
            _function = (newAdress) {
              Firestore.instance.collection("Users").document(
                  UserModel.of(context).firebaseUser!.uid.toString()
              ).updateData({"adress": newAdress});
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Endereço Atualizado!"),
                backgroundColor: Theme.of(context).primaryColor,
                duration: Duration(seconds: 2),
              ));
            };
            break;

          case "senha":
            _valueText = "";
            _function = (newPassword) {
              UserModel.of(context).firebaseUser!.updatePassword(newPassword);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Senha Atualizada!"),
                backgroundColor: Theme.of(context).primaryColor,
                duration: Duration(seconds: 2),
              ));
            };
            break;
          default:
            _valueText = "";
            _function = (text){};
            break;
        }

        return Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ListTileTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            contentPadding: EdgeInsets.zero,
            child: IgnorePointer(
              ignoring: _block,
              child: ExpansionTile(
                title: Text(this.title,
                    style: TextStyle(fontWeight: FontWeight.w600)),
                leading: CircleAvatar(
                  child: Icon(icon, color: _iconColor,),
                  backgroundColor: Colors.grey.withOpacity(0.08),
                ),
                collapsedTextColor: _textColor,
                iconColor: _textColor,
                collapsedIconColor: _textColor,
                textColor: _textColor,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: title != "Endereço" ? TextFormField(
                      decoration: InputDecoration(
                        labelText: title
                      ),
                      initialValue: _valueText,
                      //model.userData[title],
                      onFieldSubmitted: (text) => _function!(text),
                    )
                    :
                    Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Nome do remetente",
                          ),
                          initialValue: model.userData["name"],
                          //model.userData[title],
                          onFieldSubmitted: (text) {},
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Endereço",
                          ),
                          initialValue: _valueText,
                          //model.userData[title],
                          onFieldSubmitted: (text) {}
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
