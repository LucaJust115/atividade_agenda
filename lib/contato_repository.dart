import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class Contato {
  final int? id; // id exclusivo p/ cada contato, autoincrementado no banco de dados
  final String nome;
  final String telefone;
  final String email;

  Contato({this.id, required this.nome, required this.telefone, required this.email});

  Map<String, dynamic> toMap() {  // converter um obj Contato p/ um Map p/ salvar no BD
    return {
      'id': id,
      'nome': nome,
      'telefone': telefone,
      'email': email,
    };
  }

  factory Contato.fromMap(Map<String, dynamic> map) { // criar um obj Contato de um Map do BD
    return Contato(
      id: map['id'],
      nome: map['nome'],
      telefone: map['telefone'],
      email: map['email'],
    );
  }
}

class ContatoRepository {
  Database? _database; // BD que será inicializado e usado pelo repositório

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'contatos.db');

    return openDatabase(
      dbPath,
      onCreate: (db, version) {

        return db.execute(
          'CREATE TABLE contatos(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, telefone TEXT, email TEXT)', // cria a table de contatos ao iniciar o BD
        );
      },
      version: 1,
    );
  }

  Future<Database> _getDatabase() async {
    if (_database != null) {
      return _database!; // retorna o BD se já estiver iniciado
    }
    _database = await _initDatabase(); // inicializa o BD se ainda não estiver
    return _database!;
  }

  Future<void> addContato(Contato contato) async { // add um contato ao BD
    final db = await _getDatabase();
    await db.insert(
      'contatos',
      contato.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, // substitui o registro se houver conflito de ID
    );
  }

  Future<void> updateContato(Contato contato) async { // atualizar um contato existente no BD
    final db = await _getDatabase(); // Obtém o banco de dados
    await db.update(
      'contatos',
      contato.toMap(),
      where: 'id = ?',
      whereArgs: [contato.id], // passa o ID do contato como arg para a condicao
    );
  }

  Future<void> removeContato(int id) async { // remover um contato do BD
    final db = await _getDatabase();
    await db.delete(
      'contatos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Contato>> getContatos() async { // lista todos os contatos armazenados
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('contatos');

    return List.generate(maps.length, (i) {
      return Contato.fromMap(maps[i]);
    });
  }
}
