import 'dart:io';
import "dart:async";
import "dart:convert";
import 'package:flutter/material.dart';
import 'package:loja_anuncios/model/user.dart';
import 'package:loja_anuncios/model/anuncio.dart';
import 'package:loja_anuncios/pages/Home.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../CRUD/crud_anuncio.dart';

class TelaCriacaoDeAnuncio extends StatefulWidget {
  const TelaCriacaoDeAnuncio({Key? key}) : super(key: key);

  @override
  State<TelaCriacaoDeAnuncio> createState() => _TelaCriacaoDeAnuncioState();
}

class _TelaCriacaoDeAnuncioState extends State<TelaCriacaoDeAnuncio> {
  late List<Anuncio> anuncios = [];
  List _listaAnuncios = [];
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

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
      state: _controllerName.text,
      category: _controllerEmail.text,
      title: _controllerPassword.text,
      price: 10,
      telephone: '10',
      description: 'bla',
      skUser: 0,
    );

    await AnunciosDatabase.instance.create(anuncio);

    setState(() {
      _listaAnuncios.add(anuncio);
    });
    _controllerName.text = "";
    _controllerEmail.text = "";
    _controllerPassword.text = "";
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
                "CRIAR CONTA",
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
                controller: _controllerName,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Informe o nome de usuário'),
              ),
            ),
            Padding(
              padding:
              EdgeInsets.only(bottom: 20, left: 20, right: 20),
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
                  print(_controllerEmail.text);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ));
                },
                child: Text(
                  "CONTINUAR",
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
                  Text("Já possui cadastro?"),
                  TextButton(
                    onPressed: () {
                      addAnuncio();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ));
                    },
                    child: Text("Entrar"),

                  ),
                ],
              ),
              // Text("ou"),
              // Padding(padding: const EdgeInsets.symmetric(horizontal: 107),
              //   child: TextButton(
              //     onPressed: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => Cadastro(),
              //           ));
              //     },
              //     child: Text("Entrar como Convidado",style: TextStyle(color: Colors.black54),),
              //   ),)
            ],)
          ],
        ),
      ),
    );
  }
}
