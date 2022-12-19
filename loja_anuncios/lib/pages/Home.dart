import 'dart:io';
import "dart:async";
import "dart:convert";
import 'package:flutter/material.dart';
import 'package:loja_anuncios/model/user.dart';
import 'package:loja_anuncios/model/anuncio.dart';
import 'package:loja_anuncios/pages/cadastro_user.dart';
import 'package:loja_anuncios/pages/page_anuncios_main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../CRUD/crud_user.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<User> users = [];
  List _listaUsers = [];
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  Future refreshNotes() async {
    _listaUsers = await UsersDatabase.instance.readAllNotes();
  }

  Future addUser() async {
    final user = User(
      name: _controllerName.text,
      email: _controllerEmail.text,
      password: _controllerPassword.text,
    );

    await UsersDatabase.instance.create(user);

    setState(() {
      _listaUsers.add(user);
    });
    _controllerName.text = "";
    _controllerEmail.text = "";
    _controllerPassword.text = "";
  }

  @override
  Widget build(BuildContext context) {
    print("items:$users");
    return Scaffold(
      appBar: AppBar(
        title: Text("Loja do Perigo"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: Text(
                "FAZER LOGIN",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(bottom: 20, top: 50, left: 20, right: 20),
              child: TextFormField(
                onChanged: (text) {},
                controller: _controllerEmail,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.mail),
                  labelText: 'Informe o email',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: TextFormField(
                onChanged: (text) {},
                controller: _controllerPassword,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.key),
                    labelText: 'Informe a senha'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20, left: 90, right: 90),
              child: OutlinedButton.icon(
                icon: Icon(
                  Icons.login,
                  color: Colors.white,
                ),
                style: OutlinedButton.styleFrom(
                    minimumSize: const Size(0, 50),
                    backgroundColor: Colors.deepOrange),
                onPressed: () {
                  bool status = false;
                  for (var i = 0; i < _listaUsers.length; i++) {
                    if (_listaUsers[i].email == _controllerEmail.text && _listaUsers[i].password == _controllerPassword.text){
                      status = true;
                      print("Achou");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Main(id: _listaUsers[i].id),
                          ));
                    }
                  }
                  if (status == false){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Erro"),
                          content: const Text(
                              "Email e/ou senha inválida"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Ok"),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  print(_controllerEmail.text);

                },
                label: Text(
                  "ENTRAR",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                top: BorderSide(width: 1, color: Colors.black26),
              ))),
            ),
            Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Novo no Perigo?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Cadastro(),
                          ));
                    },
                    child: Text("Cadastre-se"),

                  ),
                ],
              ),
              Text("ou"),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 107),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Cadastro(),
                        ));
                  },
                  child: Text("Entrar como Convidado",style: TextStyle(color: Colors.black54),),
                ),)
            ],)
          ],
        ),
      ),
    );
  }
}
