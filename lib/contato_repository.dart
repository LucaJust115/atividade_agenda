import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Contato {
  final int? id;
  final String nome;
  final String telefone;
  final String email;

  Contato({this.id, required this.nome, required this.telefone, required this.email});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'telefone': telefone,
      'email': email,
    };
  }

  factory Contato.fromMap(Map<String, dynamic> map) {
    return Contato(
      id: map['id'],
      nome: map['nome'],
      telefone: map['telefone'],
      email: map['email'],
    );
  }
}

class Usuario {
  final int? id;
  final String nome;

  Usuario({this.id, required this.nome});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'],
      nome: map['nome'],
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
          '''
          CREATE TABLE contatos(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            nome TEXT, 
            telefone TEXT, 
            email TEXT
          );
          CREATE TABLE usuarios(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            nome TEXT
          );
          ''',
        );
      },
      version: 1,
    );
  }

  Future<void> addContato(Contato contato) async { // add um contato ao BD
    final db = await _getDatabase();
    await db.insert(
      'contatos',
      contato.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, // substitui o registro se houver conflito de ID
    );
  }

  Future<List<Contato>> getContatos() async { // lista todos os contatos armazenados
    final db = await _getDatabase(); // Obtém o banco de dados
    final List<Map<String, dynamic>> maps = await db.query('contatos');

    return List.generate(maps.length, (i) {
      return Contato.fromMap(maps[i]);
    });
  }

  Future<void> removeContato(int id) async { // remover um contato do BD
    final db = await _getDatabase();
    await db.delete(
      'contatos',
      where: 'id = ?',
      whereArgs: [id], // passa o ID do contato como arg para a condicao
    );
  }

  Future<void> addUsuario(Usuario usuario) async {
    final db = await _getDatabase();
    await db.insert(
      'usuarios',
      usuario.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Usuario?> getUsuario(String nome) async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(
      'usuarios',
      where: 'nome = ?',
      whereArgs: [nome],
    );

    if (maps.isNotEmpty) {
      return Usuario.fromMap(maps.first);
    }
    return null;
  }

  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await _initDatabase();
    }
    return _database!;
  }
}
