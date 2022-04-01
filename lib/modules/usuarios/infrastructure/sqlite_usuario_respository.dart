import 'package:sqflite/sqflite.dart';
import 'package:test_itti_flutter/modules/usuarios/domain/usuario_entity.dart';
import 'package:test_itti_flutter/modules/usuarios/domain/usuario_repository.dart';

class SqliteUsuarioRepository implements UsuarioRepository {
  final Database _database;
  final String _tableName = "usuarios";

  SqliteUsuarioRepository(this._database);

  Future<int> create(UsuarioEntity usuarioEntity) async {
    Map<String, dynamic> usuarioJson = usuarioEntity.toJson();
    return _database.insert(_tableName, usuarioJson);
  }

  Future<int> update(UsuarioEntity usuarioEntity) async {
    Map<String, dynamic> usuarioJson = usuarioEntity.toJson();
    return _database.update(
      _tableName,
      usuarioJson,
      where: "id = ?",
      whereArgs: [usuarioEntity.id],
    );
  }

  @override
  Future<List<UsuarioEntity>> getAll() async {
    List<Map<String, Object?>> usuarios = await _database.query(_tableName);
    if (usuarios.isEmpty) {
      return [];
    }

    return usuarios.map((usuario) => UsuarioEntity.fromJson(usuario)).toList();
  }

  @override
  Future<UsuarioEntity?> getOne(String id) async {
    List<Map<String, Object?>> usuarios = await _database.query(_tableName,
        where: "id = ?", whereArgs: [id], limit: 1);

    if (usuarios.isEmpty) {
      return null;
    }

    UsuarioEntity usuario = UsuarioEntity.fromJson(usuarios.first);

    return usuario;
  }
}
