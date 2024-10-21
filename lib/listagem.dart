import 'package:flutter/material.dart';
import 'contato_repository.dart';

class Listagem extends StatefulWidget {
  final ContatoRepository contatos;

  Listagem({required this.contatos});

  @override
  _ListagemState createState() => _ListagemState();
}

class _ListagemState extends State<Listagem> {
  late Future<List<Contato>> _contatos;

  @override
  void initState() {
    super.initState();
    _contatos = widget.contatos.getContatos();
  }

  void _removerContato(int id) {
    widget.contatos.removeContato(id);
    setState(() {
      _contatos = widget.contatos.getContatos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
      ),
      body: FutureBuilder<List<Contato>>(
        future: _contatos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar contatos'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum contato encontrado'));
          }

          final contatos = snapshot.data!;

          return ListView.builder(
            itemCount: contatos.length,
            itemBuilder: (context, index) {
              final contato = contatos[index];
              return ListTile(
                title: Text(contato.nome),
                subtitle: Text(contato.telefone),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _removerContato(contato.id!),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
