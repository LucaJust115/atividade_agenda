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
  final ContatoRepository contatos;
  final Contato? contato;
  final int? index;
  Cadastro({required this.contatos, this.contato, this.index});

  @override
  State<Cadastro> createState() => _CadastroState(contatos: contatos, contato: contato, index: index);
}

class _CadastroState extends State<Cadastro> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final ContatoRepository contatos;
  final Contato? contato;
  final int? index;

  _CadastroState({required this.contatos, this.contato, this.index});

  @override
  void initState() {
    super.initState();
    if (contato != null) {
      nomeController.text = contato!.nome;
      telefoneController.text = contato!.telefone;
      emailController.text = contato!.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contato == null ? 'Cadastro de Contato' : 'Editar Contato'),
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
              decoration: InputDecoration(labelText: 'Entre com telefone'),
              controller: telefoneController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Entre com email'),
              controller: emailController,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (contato == null) {
                    contatos.addContato(Contato(
                        nome: nomeController.text,
                        telefone: telefoneController.text,
                        email: emailController.text));
                  } else {
                    contatos.updateContato(
                      index!,
                      Contato(
                        nome: nomeController.text,
                        telefone: telefoneController.text,
                        email: emailController.text,
                      ),
                    );
                  }
                });
                Navigator.pop(context);
              },
              child: Text(contato == null ? 'Salvar' : 'Editar'),
            ),
          ],
        ),
      ),
    );
  }
}

class Principal extends StatelessWidget {
  final ContatoRepository contatos = ContatoRepository();

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
                  builder: (context) => Cadastro(contatos: contatos),
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
                  builder: (context) => Listagem(contatos: contatos),
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
  final ContatoRepository contatos;
  Listagem({required this.contatos});

  @override
  State<Listagem> createState() => ListagemState(contatos: contatos);
}

class ListagemState extends State<Listagem> {
  final ContatoRepository contatos;

  ListagemState({required this.contatos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listagem de Contatos'),
      ),
      body: ListView.builder(
        itemCount: contatos.getContatos().length,
        itemBuilder: (context, index) {
          Contato c = contatos.getContatos()[index];
          return ListTile(
            title: Text(c.nome),
            subtitle: Text("telefone: " + c.telefone + "\nemail: " + c.email),
            trailing: Icon(Icons.more_vert),  // Ícone de três pontinhos indicando mais opções
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Opções"),
                  content: Text("Deseja editar ou remover o contato?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Cadastro(contatos: contatos, contato: c, index: index),
                          ),
                        );
                      },
                      child: Text('Editar'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          contatos.removeContato(index);
                        });
                        Navigator.pop(context);
                      },
                      child: Text('Remover'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Contato {
  final String nome;
  final String telefone;
  final String email;
  Contato({required this.nome, required this.telefone, required this.email});
}

class ContatoRepository {
  final List<Contato> contatos = [];

  void addContato(Contato c) {
    contatos.add(c);
  }

  void updateContato(int index, Contato c) {
    contatos[index] = c;
  }

  void removeContato(int index) {
    contatos.removeAt(index);
  }

  List<Contato> getContatos() {
    return contatos;
  }
}
