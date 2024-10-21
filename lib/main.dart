import 'package:flutter/material.dart';
import 'contato_repository.dart';
import 'login.dart';
import 'listagem.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciador de Contatos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<String?>(
        future: _getToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            final token = snapshot.data;
            if (token != null) {
              return Listagem(contatos: ContatoRepository()); // carrega tela de listagem se houver token
            } else {
              return Login(contatos: ContatoRepository()); // carrega tela de login
            }
          }
        },
      ),
    );
  }

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('usuario');
  }
}