import 'dart:io';
import "dart:async";
import "dart:convert";
import 'package:flutter/material.dart';
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

class Main extends StatelessWidget {
  Main({Key? key, required this.id}) : super(key: key);

  int id;

  PopupMenuItem _buildPopupMenuItem(String title, Icon icon,BuildContext context) {
    return PopupMenuItem(
      child: ListTile(
        leading: icon,
        title: TextButton(onPressed: (){Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TelaCriacaoDeAnuncio(id: id),
            ));}, child: Text(title)),
      ),

    );
  }

  @override
  Widget build(BuildContext context) {
    print(id);
    return Scaffold(
      appBar: AppBar(
        title: Text("Loja do Perigo"),
        backgroundColor: Colors.black,
        actions: [
          PopupMenuButton(
              itemBuilder: (ctx) => [
                    _buildPopupMenuItem("Meus anuncios", Icon(Icons.inbox),context),
                    _buildPopupMenuItem("Criar anuncio", Icon(Icons.add),context)
                  ])
        ],
      ),
      body: Container(
        child: ListView(
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
            TextButton(onPressed: (){Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ));}, child: Text("Cachorro"))
            // Column(children: [
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text("Já possui cadastro?"),
            //       TextButton(
            //         onPressed: () {
            //           addUser();
            //           Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                 builder: (context) => Home(),
            //               ));
            //         },
            //         child: Text("Entrar"),
            //
            //       ),
            //     ],
            //   ),
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
            //],)
          ],
        ),
      ),
    );
  }
}
