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

  String? _validarNome(String? value) {
    if (value == null || value.isEmpty) {
      return 'O nome não pode estar vazio'; // validação para o campo nome
    }
    return null;
  }

  String? _validarTelefone(String? value) {
    if (value == null || value.isEmpty) {
      return 'O telefone não pode estar vazio';
    }
    if (value.length != 11) {
      return 'O telefone deve ter 11 dígitos'; // verifica se a quantidade de dígitos está correta
    }
    return null;
  }

  String? _validarEmail(String? value) {
    if (value == null || !value.contains('@')) { // verifica se e um endereco de email com '@'
      return 'Email inválido. Deve conter @';
    }
    return null;
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
                validator: _validarNome, // chama a funcao de validacao
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Telefone (somente números)'),
                controller: telefoneController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // permitir apenas números (TENTEI USAR O REGEX MAS FRACASSEI E NAO PRESTOU DE FORMA ALGUMA)
                ],
                validator: _validarTelefone,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: _validarEmail,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      if (contato == null) {
                        contatos.addContato(Contato(
                          nome: nomeController.text,
                          telefone: telefoneController.text,
                          email: emailController.text,
                        ));
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
                  }
                },
                child: Text(contato == null ? 'Salvar' : 'Editar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
