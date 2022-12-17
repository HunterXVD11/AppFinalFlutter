import 'dart:io';
import "dart:async";
import "dart:convert";
import 'package:flutter/material.dart';
import 'package:loja_anuncios/model/user.dart';
import 'package:loja_anuncios/model/anuncio.dart';
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
              padding: EdgeInsets.only(bottom: 20, left: 75, right: 75),
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 50),
                      backgroundColor: Colors.black),
                  onPressed: () {
                    print(_controllerEmail.text);
                  },
                  child: Text(
                    "CONFIRMAR",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
