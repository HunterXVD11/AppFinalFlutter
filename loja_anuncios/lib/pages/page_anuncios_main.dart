import 'dart:io';
import "dart:async";
import "dart:convert";
import 'package:flutter/material.dart';
import 'package:loja_anuncios/model/user.dart';
import 'package:loja_anuncios/model/anuncio.dart';
import 'package:loja_anuncios/pages/cadastro_user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../CRUD/crud_user.dart';

class Main extends StatelessWidget {
  Main({Key? key,required this.id}) : super(key: key);

  int id;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

