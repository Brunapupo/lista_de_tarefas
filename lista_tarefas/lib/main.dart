import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _toDoController = TextEditingController();

  List _toDoList = [];

  //função para adionar itens na lista
  void _addTodoDo() {
    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo['title'] = _toDoController.text;
      _toDoController.text = '';
      newToDo['ok'] = false;
      _toDoList.add(newToDo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de Tarefas',
          style: TextStyle(
            color: Color(0xFF1C1B1F),
            fontSize: 25,
          ),
        ),
        backgroundColor: const Color(0xFFFFD8E4),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _toDoController,
                    decoration: const InputDecoration(
                      labelText: 'Nova Tarefa',
                      labelStyle: TextStyle(
                        color: Color(0xFF1C1B1F),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _addTodoDo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE7E0EC),
                  ),
                  child: const Text(
                    'Add',
                    style: TextStyle(
                      color: Color(0XFF1C1B1F),
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.only(top: 10.0),
                itemCount: _toDoList.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(_toDoList[index]['title']),
                    value: _toDoList[index]['ok'],
                    secondary: CircleAvatar(
                      backgroundColor: const Color(0xFFFFD8E4),
                      child: Icon(
                          color: Color(0xFF1C1B1F),
                          _toDoList[index]['ok'] ? Icons.check : Icons.error),),
                    onChanged: (c) {
                      setState(() {
                        _toDoList[index]['ok'] = c;
                      });
                    },
                  );
                }),
          )
        ],
      ),
    );
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  // peguei o arquivo que obtive do _getFile escrevei os dados na lista de tarefa
  Future<File> _saveData() async {
    String data = json.encode(_toDoList);

    final file = await _getFile();
    return file.writeAsString(data);
  }

  //usando o Try catch
  Future<String?> _readData() async {
    try {
      final file = await _getFile();

      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}

// Expanded(
// child: ListView.builder(
// padding: EdgeInsets.only(top: 10.0),
// itemCount: _toDoList.length,
// itemBuilder: (context, index) {
// return CheckboxListTile(
// title: Text(_toDoList[index]['title']),
// value: _toDoList[index]['ok'],
//
// secondary: CircleAvatar(
// backgroundColor: const Color(0xFFFFD8E4),
// child: Icon(
// color: const Color(0xFF1C1B1F),
// _toDoList[index]['ok'] ? Icons.check : Icons.error),
// ),
// onChanged: (c) {
// setState(() {
// _toDoList[index]['ok'] = c;
// _saveData();
// });
// },
// );
// }),
// )
