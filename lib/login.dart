import 'package:flutter/material.dart';
import 'contato_repository.dart';
import 'cadastro.dart';
import 'listagem.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  final ContatoRepository contatos;

  Login({required this.contatos});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  late String _nome;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final usuario = await widget.contatos.getUsuario(_nome);

      if (usuario != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('usuario', _nome);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Listagem(contatos: widget.contatos),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuário não encontrado')),
        );
      }
    }
  }

  void _cadastrar() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Cadastro(contatos: widget.contatos),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                onSaved: (value) => _nome = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
              ),
              TextButton(
                onPressed: _cadastrar,
                child: Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
