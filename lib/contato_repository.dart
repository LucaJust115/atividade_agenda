class Contato {
  final String nome;
  final String telefone;
  final String email;
  Contato({required this.nome, required this.telefone, required this.email});
}

class ContatoRepository {
  final List<Contato> contatos = []; //lista de contatos

  void addContato(Contato c) {
    contatos.add(c);
  }

  void updateContato(int index, Contato c) {
    contatos[index] = c;
  }

  void removeContato(int index) {
    contatos.removeAt(index);
  }

  List<Contato> getContatos() { //retorna os contatos que estao na lista
    return contatos;
  }
}
