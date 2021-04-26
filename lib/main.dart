import 'dart:convert';
import 'package:APIexample/API.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// -------------------------------- Conectando API --------------------------------//
  List<Api> _api =
      List(); // Criando lista chamando a classe Api que está contida na API.dart

  Future<List<Api>> _getuser() async {
    try {
      List<Api> listUser = List();
      final response =
          await http.get('https://jsonplaceholder.typicode.com/users');
      if (response.statusCode == 200) {
        var descodeJson = jsonDecode(response.body);
        descodeJson.forEach((item) => listUser.add(Api.fromJson(item)));
        return listUser;
      } else {
        print("Erro ao carregar lista");
        return null;
      }
    } catch (e) {
      print("Erro ao carregar lista");
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _getuser().then((map) {
      setState(() {
        _api = map;
        print(_api.length); // Só testando o tamanho de items da API
      });
    });
  }

// -------------------------------- Criando a Tela --------------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: _api.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 80,
                color: Colors.blue,
                child: Text(_api[index].email),
              ),
            );
          },
        ),
      ),
    );
  }
}
