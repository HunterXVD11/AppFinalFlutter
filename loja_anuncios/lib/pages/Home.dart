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
    List _listaUsers = [];
    TextEditingController _controllerTarefa = TextEditingController();

    Future addUser() async {
      final user = User(
        name: _controllerTarefa.text,
        email: _controllerTarefa.text,
        password: _controllerTarefa.text,
      );

      await UsersDatabase.instance.create(user);

      setState(() {
        _listaUsers.add(user);
      });
      _controllerTarefa.text = "";
    }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
