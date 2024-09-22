import 'package:flutter/material.dart';
import 'contato_repository.dart';

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
