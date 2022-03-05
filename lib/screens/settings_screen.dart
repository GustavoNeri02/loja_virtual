import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/widgets/config_list_tile.dart';
import 'package:loja_virtual/widgets/config_singular_list_tile.dart';
import 'package:loja_virtual/widgets/config_user_exp_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: 140,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          leading: Container(),
          leadingWidth: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Configurações",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Informações da conta",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.white,
                    child: UserModel.of(context).isLoggedIn() &&
                            UserModel.of(context).userData["image"] != null
                        ? Image.network(
                            UserModel.of(context).userData["image"],
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 32, right: 32, bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Login e segurança",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.withOpacity(0.7),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          ConfigUserExpTile(Icons.person_outline, "Nome"),
                          ConfigUserExpTile(Icons.phone_outlined, "Telefone"),
                          ConfigUserExpTile(Icons.email_outlined, "E-mail"),
                          ConfigUserExpTile(Icons.location_pin, "Endereço"),
                          ConfigUserExpTile(Icons.password, "Redefinir Senha"),
                          SizedBox(
                            height: 30,
                            child: Divider(),
                          ),
                          Text(
                            "Outros",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.withOpacity(0.7),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          ConfigListTile(Icons.notifications_outlined,
                              "Notificações", () {}),
                          ConfigListTile(Icons.remove_red_eye_outlined,
                              "Aparência", () {}),
                          ConfigListTile(
                              Icons.headset_outlined, "Ajuda e Suporte", () {}),
                          ConfigListTile(Icons.help_outline, "Sobre", () {}),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                ConfigSingularListTile(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
