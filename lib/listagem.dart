import 'package:flutter/material.dart';
import 'contato_repository.dart';
import 'cadastro.dart';

class Listagem extends StatefulWidget {
  final ContatoRepository contatos;
  Listagem({required this.contatos});

  @override
  State<Listagem> createState() => _ListagemState(contatos: contatos);
}

class _ListagemState extends State<Listagem> {
  final ContatoRepository contatos;
  _ListagemState({required this.contatos});

  List<Contato> listaContatos = [];

  void carregarContatos() async {
    final contatosDb = await contatos.getContatos();
    setState(() {
      listaContatos = contatosDb;
    });
  }

  @override
  void initState() {
    super.initState();
    carregarContatos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Contatos'),
      ),
      body: ListView.builder(
        itemCount: listaContatos.length,
        itemBuilder: (context, index) {
          final c = listaContatos[index];
          return ListTile(
            title: Text(c.nome),
            subtitle: Text(c.telefone),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Opções"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text("Editar"),
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Cadastro(contatos: contatos, contato: c),
                              ),
                            );
                            carregarContatos(); // da reload nos contatos apos a edicao
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: Text("Excluir"),
                          onTap: () async {
                            await contatos.removeContato(c.id!); // remove o contato selecionado
                            carregarContatos(); // da reload nos contatos apos a remocao
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

