import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class ConfigExpTile extends StatelessWidget {
  IconData icon;
  String title;

  ConfigExpTile(this.icon, this.title);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model) {
        String? valueText;

        switch (title) {
          case "Nome":
            valueText = model.userData["name"];
            break;

          case "Telefone":
            if (model.userData["phone"] == null) {
              valueText = "Adicione um novo número de telefone!";
            } else {
              valueText = model.userData["phone"];
            }

            break;

          case "E-mail":
            valueText = model.userData["email"];
            break;

          default:
            valueText = "";
            break;
        }

        return Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ListTileTheme(
            contentPadding: EdgeInsets.zero,
            child: ExpansionTile(
              title: Text(this.title,
                  style: TextStyle(fontWeight: FontWeight.w600)),
              leading: CircleAvatar(
                child: Icon(icon),
                backgroundColor: Colors.grey.withOpacity(0.08),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: valueText,
                    ),
                    initialValue: "",
                    //model.userData[title],
                    onFieldSubmitted: (text) {},
                    onTap: () {
                      print(model.userData);
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
