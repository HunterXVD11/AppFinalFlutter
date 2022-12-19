import 'dart:io';
import "dart:async";
import "dart:convert";
import 'package:flutter/material.dart';
import 'package:loja_anuncios/model/user.dart';
import 'package:loja_anuncios/model/anuncio.dart';
import 'package:loja_anuncios/pages/Home.dart';
import 'package:loja_anuncios/pages/page_anuncios_main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../CRUD/crud_anuncio.dart';

class TelaCriacaoDeAnuncio extends StatefulWidget {
  TelaCriacaoDeAnuncio({Key? key, required this.id}) : super(key: key);

  int id;
  @override
  State<TelaCriacaoDeAnuncio> createState() => _TelaCriacaoDeAnuncioState();
}

class _TelaCriacaoDeAnuncioState extends State<TelaCriacaoDeAnuncio> {
  late List<Anuncio> anuncios = [];
  List _listaAnuncios = [];
  TextEditingController _controllerState = TextEditingController();
  TextEditingController _controllerCategory = TextEditingController();
  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerPrice= TextEditingController();
  TextEditingController _controllerTelephone = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();

  @override
  void initState() {
    super.initState();
    refreshAnuncios();
  }

  Future refreshAnuncios() async {
    _listaAnuncios = await AnunciosDatabase.instance.readAllAnuncios();
  }

  Future addAnuncio() async {
    final anuncio = Anuncio(
      state: _controllerState.text,
      category: _controllerCategory.text,
      title: _controllerTitle.text,
      price: double.parse(_controllerPrice.text),
      telephone: _controllerTelephone.text,
      description: _controllerDescription.text,
      skUser: widget.id,
    );

    await AnunciosDatabase.instance.create(anuncio);

    setState(() {
      _listaAnuncios.add(anuncio);
    });
    for (int i = 0;i < _listaAnuncios.length;i++){
      print("ListavDD = ${_listaAnuncios[i].title}, ");
    }

    _controllerState.text = "";
    _controllerCategory.text = "";
    _controllerTitle.text = "";
    _controllerPrice.text = "";
    _controllerTelephone.text = "";
    _controllerDescription.text = "";
  }

  @override
  Widget build(BuildContext context) {
    print("items:$anuncios");
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
                "NOVO ANÚNCIO",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 50, left: 20, right: 20),
              child: TextFormField(
                onChanged: (text) {},
                controller: _controllerState,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.loop),
                    labelText: 'Informe o estado do produto'),
              ),
            ),
            Padding(
              padding:
              EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: TextFormField(
                onChanged: (text) {},
                controller: _controllerCategory,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                  labelText: 'Informe a categoria do produto',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: TextFormField(
                onChanged: (text) {},
                controller: _controllerTitle,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.title),
                    labelText: 'Informe o titulo do anuncio'),
              ),
            ),
            Padding(
              padding:
              EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: TextFormField(
                onChanged: (text) {},
                controller: _controllerPrice,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.currency_bitcoin),
                  labelText: 'Informe o preço do produto',
                ),
              ),
            ),
            Padding(
              padding:
              EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: TextFormField(
                onChanged: (text) {},
                controller: _controllerTelephone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.call),
                  labelText: 'Informe o telefone de contato',
                ),
              ),
            ),
            Padding(
              padding:
              EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: TextFormField(
                onChanged: (text) {},
                controller: _controllerDescription,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                  labelText: 'Informe uma descrição para o anuncio',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20, left: 90, right: 90),
              child: OutlinedButton(
                // icon: Icon(
                //   Icons.login,
                //   color: Colors.white,
                // ),
                style: OutlinedButton.styleFrom(
                    minimumSize: const Size(0, 50),
                    backgroundColor: Colors.deepOrange),
                onPressed: () {
                  addAnuncio();
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => Main(id: widget.id),
                  //     ));
                  print("Lista = $_listaAnuncios");
                },
                child: Text(
                  "CRIAR",
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
          ],
        ),
      ),
    );
  }
}
