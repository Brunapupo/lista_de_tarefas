import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main(){
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List _toDoList = [];

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  // Função Get assincrona que retorna um arquivo que vou utilizar para salvar em json
  // salvamos em um diretorio, função 'getApp....' ela vai pegar o diretory onde eu posso armazenar
  // os docs so meu app, ele retorna um Future
  Future<File> _getFile() async {
    // Peguei o local onde eu posso armazenar os meus docs e ele está em meu diretory
    final directory = await getApplicationDocumentsDirectory();
    // peguei o caminho, ou seja, .path e abro o arquivo atráves do File
    return File("${directory.path}/data.json");
  }


  // peguei o arquivo que obtive do _getFile escrevei os dados na lista de tarefa
  Future<File> _saveData() async {
    //salvei os dados na minha lista toDoList e transfornei em um json e armazenei um String
    String data = json.encode(_toDoList);

    final file = await _getFile();
    return file.writeAsString(data);
  }

  //usando o Try catch
  Future<String?> _readData() async {
    // na hora de tentar, vou pegar o arquivo que salvei 'file', e tntar lê como String e returnar
    // caso ocorrá algum erro retorn null
    try {
      final file = await _getFile();

      return file.readAsString();
    } catch (e) {
      return null;
    }
  }

}