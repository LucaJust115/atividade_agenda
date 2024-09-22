import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Principal(),
    );
  }
}

class Cadastro extends StatefulWidget {
  final CarrosRepository carros;
  Cadastro({required this.carros});

  @override
  State<Cadastro> createState() => _CadastroState(carros: carros);
}

class _CadastroState extends State<Cadastro> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController corController = TextEditingController();
  final CarrosRepository carros;

  _CadastroState({required this.carros});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Carros'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Entre com nome'),
              controller: nomeController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Entre com cor'),
              controller: corController,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  carros.addCarros(Carro(
                      nome: nomeController.text, cor: corController.text));
                });
                Navigator.pop(context);
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}

class Principal extends StatelessWidget {
  final CarrosRepository carros = CarrosRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Principal'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Cadastro(carros: carros),
                ),
              );
            },
            child: Text("Cadastro"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Listagem(carros: carros),
                ),
              );
            },
            child: Text("Listar"),
          ),
        ],
      ),
    );
  }
}

class Listagem extends StatefulWidget {
  final CarrosRepository carros;
  Listagem({required this.carros});

  @override
  State<Listagem> createState() => ListagemState(carros: carros);
}

class ListagemState extends State<Listagem> {
  final CarrosRepository carros;

  ListagemState({required this.carros});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listagem de Carros'),
      ),
      body: ListView.builder(
        itemCount: carros.getCarros().length,
        itemBuilder: (context, index) {
          Carro c = carros.getCarros()[index];
          return ListTile(
            title: Text(c.nome),
            subtitle: Text(c.cor),
          );
        },
      ),
    );
  }
}

class Carro {
  final String nome;
  final String cor;
  Carro({required this.nome, required this.cor});
}

class CarrosRepository {
  final List<Carro> carros = [];

  void addCarros(Carro c) {
    carros.add(c);
  }

  List<Carro> getCarros() {
    return carros;
  }
}