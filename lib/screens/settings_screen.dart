import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/widgets/config_exp_tile.dart';

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
          title: Column(
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
                          ConfigExpTile(Icons.person_outline, "Nome"),
                          ConfigExpTile(Icons.phone_outlined, "Telefone"),
                          ConfigExpTile(Icons.email_outlined, "E-mail"),
                          SizedBox(
                            height: 30,
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
                          ConfigExpTile(
                              Icons.notifications_outlined, "Notificações"),
                          ConfigExpTile(
                              Icons.remove_red_eye_outlined, "Aparência"),
                          ConfigExpTile(
                              Icons.headset_outlined, "Ajuda e Suporte"),
                          ConfigExpTile(Icons.help_outline, "Sobre"),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                InkWell(
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
                                      Icons.power_settings_new,
                                      color: Colors.redAccent,
                                    ),
                                    backgroundColor:
                                        Colors.grey.withOpacity(0.08)),
                                title: Text(
                                  "Deletar Conta",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  onTap: UserModel.of(context).firebaseUser == null ? () {
                    UserModel.of(context).firebaseUser!.delete();
                  } : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
