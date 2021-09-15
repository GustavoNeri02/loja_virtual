import 'package:flutter/material.dart';

class RegisteScreen extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: "Nome Completo",
              ),
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              validator: (text){
                if (text == null || text.isEmpty || !text.contains(" ")) {
                  return "Nome completo inválido!";
                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "E-mail",
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (text){
                if (text == null || text.isEmpty || !text.contains("@")) {
                  return "E-mail inválido!";
                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Senha",
              ),
              obscureText: true,
              validator: (text){
                if (text == null || text.isEmpty || text.length < 6) {
                  return "Senha inválida!";
                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Endereço",
              ),
              keyboardType: TextInputType.streetAddress,
              validator: (text){
                if (text == null || text.isEmpty || text.length < 10) {
                  return "Endereço inválido!";
                }
              },
            ),
            SizedBox(height: 16,),
            SizedBox(
              height: 44,
              child: ElevatedButton(
                  onPressed: (){
                    if(_formkey.currentState!.validate()){

                    }
                  },
                  child: Text("Criar Conta",
                    style: TextStyle(fontSize: 18),
                  ),
                style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
