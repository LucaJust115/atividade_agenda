import 'package:flutter/material.dart';
import 'contato_repository.dart';
import 'cadastro.dart';

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
  Widget build(BuildContext context) { //opcoes esteticas do codigo
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
            trailing: Icon(Icons.more_vert),  // icone de três pontinhos indicando mais opções
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
