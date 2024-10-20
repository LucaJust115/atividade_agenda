import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final _formKey = GlobalKey<FormState>();
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                controller: nomeController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O nome não pode estar vazio';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Telefone (somente números)'),
                controller: telefoneController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O telefone não pode estar vazio';
                  }
                  if (value.length != 11) {
                    return 'O telefone deve ter 11 dígitos';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || !value.contains('@')) {
                    return 'Email inválido. Deve conter @';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // ADD botao p/ voltar à tela anterior
                    },
                    child: Text('Voltar'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final novoContato = Contato(
                          id: contato?.id,
                          nome: nomeController.text,
                          telefone: telefoneController.text,
                          email: emailController.text,
                        );
                        if (contato == null) {
                          await contatos.addContato(novoContato); // add novo contato
                        } else {
                          await contatos.updateContato(novoContato); // faz o update do contato
                        }
                        Navigator.pop(context);
                      }
                    },
                    child: Text(contato == null ? 'Salvar' : 'Editar'), // add botao para salvar ou editar
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
