import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final _secureStorage = const FlutterSecureStorage();

  // SALVAR OS DADOS
  Future<void> saveSession(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  // RECUPERAR
  Future<String?> getSession(String key) async {
    return await _secureStorage.read(key: key);
  }

  // DELETAR SESSAO
  Future<void> deleteSession(String key) async {
    await _secureStorage.delete(key: key);
  }

  // LIMPAR
  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }
}
