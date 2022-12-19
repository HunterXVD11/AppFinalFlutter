import 'dart:io';
import "dart:async";
import "dart:convert";
import 'package:flutter/material.dart';
import 'package:loja_anuncios/CRUD/crud_anuncio.dart';
import 'package:loja_anuncios/model/user.dart';
import 'package:loja_anuncios/model/anuncio.dart';
import 'package:loja_anuncios/pages/Home.dart';
import 'package:loja_anuncios/pages/cadastro_user.dart';
import 'package:loja_anuncios/pages/create_anuncio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../CRUD/crud_user.dart';

class Main extends StatefulWidget {
  Main({Key? key, required this.id}) : super(key: key);

  int id;

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  late List<Anuncio> anuncios = [];
  List _listaAnuncios = [];

  @override
  void initState() {
    super.initState();
    refreshAnuncios();
  }

  Future refreshAnuncios() async {
    _listaAnuncios = await AnunciosDatabase.instance.readAllAnuncios();
  }

  PopupMenuItem _buildPopupMenuItem(
      String title, Icon icon, BuildContext context) {
    return PopupMenuItem(
      child: ListTile(
        leading: icon,
        title: TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaCriacaoDeAnuncio(id: widget.id),
                  ));
            },
            child: Text(title)),
      ),
    );
  }

  Widget showAnuncio(BuildContext context, int index) {
    return Scaffold(
      body: Text(_listaAnuncios[index].title),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(widget.id);
    print("items2:$anuncios");
    print("itemsLista:$_listaAnuncios");
    return Scaffold(
      appBar: AppBar(
        title: Text("Loja do Perigo"),
        backgroundColor: Colors.black,
        actions: [
          PopupMenuButton(
              itemBuilder: (ctx) => [
                    _buildPopupMenuItem(
                        "Meus anuncios", Icon(Icons.inbox), context),
                    _buildPopupMenuItem(
                        "Criar anuncio", Icon(Icons.add), context)
                  ])
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.deepOrange,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Text(
                      "O Natal chegou com tudo no Perigo".toUpperCase(),
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
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
            Flexible(
              child: ListView.builder(
                  itemCount: _listaAnuncios.length,
                  itemBuilder: (context, index) {
                    return Row(children: [

                      Column(
                        children: [
                          Text("${_listaAnuncios[index].title}"),
                          Text("${_listaAnuncios[index].description}"),
                          Text("${_listaAnuncios[index].price}"),
                        ],
                      )
                    ]);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
