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
import 'package:loja_anuncios/pages/detailed_page.dart';
import 'package:loja_anuncios/pages/meus_anuncios.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../CRUD/crud_user.dart';

//ignore: must_be_immutable
class MainPage extends StatefulWidget {
  MainPage({Key? key, required this.id, required this.name}) : super(key: key);

  String name;
  int id;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late List<Anuncio> anuncios = [];
  late List _listaAnuncios = [];

  @override
  void initState() {
    super.initState();
    refreshAnuncios();
    print("_listaAnuncios = $_listaAnuncios");
  }

  Future refreshAnuncios() async {
    _listaAnuncios = await AnunciosDatabase.instance.readAllAnuncios();
    setState(() {});
  }

  PopupMenuItem _buildPopupMenuItem(
      String title, Icon icon, BuildContext context) {
    return PopupMenuItem(
      child: ListTile(
        leading: icon,
        title: TextButton(
            onPressed: () {
              if (title == "Criar anuncio") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TelaCriacaoDeAnuncio(
                        id: widget.id,
                        name: widget.name,
                      ),
                    ));
              } else if (title == "Logout") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(),
                    ));
              } else if (title == "Meus anuncios") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Mine(
                        id: widget.id,
                        name: widget.name,
                      ),
                    ));
              }
            },
            child: Text(title)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("O id é:${widget.id}");
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
                        "Olá, ${widget.name}", Icon(Icons.person), context),
                    _buildPopupMenuItem(
                        "Meus anuncios", Icon(Icons.inbox), context),
                    _buildPopupMenuItem(
                        "Criar anuncio", Icon(Icons.add), context),
                    _buildPopupMenuItem("Logout", Icon(Icons.logout), context),
                  ])
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Color.fromRGBO(235, 235, 235, 1),
            border: Border(
              top: BorderSide(width: 1, color: Colors.black26),
            )),
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
                child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 260,
                childAspectRatio: 0.78,
                // mainAxisSpacing: 10
              ),
              itemCount: _listaAnuncios.length,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      new EdgeInsets.symmetric(horizontal: 7.5, vertical: 7.5),
                  padding: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Image(
                        image: AssetImage('images/products.png'),
                        width: 100,
                        height: 100,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              "${_listaAnuncios[index].title}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5, left: 20),
                            child: Text(
                              "RS ${_listaAnuncios[index].price}",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              "À vista no PIX}",
                              style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            padding: EdgeInsets.only(top: 0),
                            child: OutlinedButton.icon(
                              icon: Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              ),
                              style: OutlinedButton.styleFrom(
                                  minimumSize: const Size(150, 30),
                                  backgroundColor: Colors.deepOrange),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Detail(
                                        id: widget.id,
                                        name: widget.name,
                                        productId: _listaAnuncios[index].id,
                                      ),
                                    ));
                              },
                              label: Text(
                                "COMPRAR",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                );
              },
            )),

            // Flexible(
            //   child: ListView.builder(
            //       itemCount: _listaAnuncios.length,
            //       itemBuilder: (context, index) {
            //         return Container(
            //           margin: new EdgeInsets.symmetric(
            //               horizontal: 20.0, vertical: 10),
            //           padding: const EdgeInsets.only(left: 30, top: 20),
            //           decoration: const BoxDecoration(color: Colors.white),
            //           child: Row(children: [
            //             Padding(
            //               padding: const EdgeInsets.only(right: 20),
            //               child: Image(
            //                 image: AssetImage('images/products.png'),
            //                 width: 100,
            //                 height: 100,
            //               ),
            //             ),
            //             Padding(
            //               padding: const EdgeInsets.only(left: 20),
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Text(
            //                     "${_listaAnuncios[index].title}",
            //                     style: TextStyle(
            //                       fontSize: 16,
            //                       fontWeight: FontWeight.bold,
            //                     ),
            //                   ),
            //                   Text("${_listaAnuncios[index].description}"),
            //                   Text(
            //                     "RS ${_listaAnuncios[index].price}",
            //                     style: TextStyle(
            //                         fontSize: 20,
            //                         color: Colors.deepOrange,
            //                         fontWeight: FontWeight.bold),
            //                   ),
            //                   Container(
            //                     alignment: Alignment.bottomLeft,
            //                     padding: EdgeInsets.only(left: 50, top: 20),
            //                     child: OutlinedButton.icon(
            //                       icon: Icon(
            //                         Icons.shopping_cart,
            //                         color: Colors.white,
            //                       ),
            //                       style: OutlinedButton.styleFrom(
            //                           minimumSize: const Size(0, 35),
            //                           backgroundColor: Colors.deepOrange),
            //                       onPressed: () {},
            //                       label: Text(
            //                         "COMPRAR",
            //                         style: const TextStyle(
            //                             fontWeight: FontWeight.bold,
            //                             color: Colors.white,
            //                             fontSize: 14),
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ]),
            //         );
            //       }),
            // ),
          ],
        ),
      ),
    );
  }
}
