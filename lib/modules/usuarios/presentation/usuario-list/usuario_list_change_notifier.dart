import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'package:test_itti_flutter/modules/usuarios/domain/usuario_entity.dart';
import 'package:test_itti_flutter/modules/usuarios/infrastructure/dio_usuario_repository.dart';
import 'package:test_itti_flutter/modules/usuarios/infrastructure/sqlite_usuario_respository.dart';

class UsuarioListChangeNotifier extends ChangeNotifier {
  List<UsuarioEntity> usuarios = [];
  final SqliteUsuarioRepository usuarioSqliteRepository =
      GetIt.I<SqliteUsuarioRepository>();
  final DioUsuarioRepository usuarioDioRepository =
      GetIt.I<DioUsuarioRepository>();

  UsuarioListChangeNotifier();

  void setUsuarios(List<UsuarioEntity> usuarioss) {
    usuarios = usuarioss;
    notifyListeners();
  }

  Future<int> addUsuario(UsuarioEntity usuario) async {
    var created = await usuarioSqliteRepository.create(usuario);
    if (created > 0) setUsuarios([...usuarios, usuario]);
    return created;
  }

  Future<int> updateUsuario(UsuarioEntity usuario) async {
    var updated = await usuarioSqliteRepository.update(usuario);
    if (updated > 0) {
      var index = usuarios.indexWhere((u) => u.id == usuario.id);
      usuarios[index] = usuario;
      var newUsuarios = [...usuarios];
      setUsuarios(newUsuarios);
    }
    return updated;
  }

  Future<List<UsuarioEntity>> getAllUsuariosLocal() async {
    return usuarioSqliteRepository.getAll();
  }

  Future<List<UsuarioEntity>> getAllUsuariosRemote() async {
    return usuarioDioRepository.getAll();
  }

  Future<UsuarioEntity?> getOneUsuario(String id) async {
    return usuarioSqliteRepository.getOne(id);
  }

  Future<void> delete(int id) async {
    await usuarioSqliteRepository.delete(id);

    usuarios.removeWhere((u) => u.id == id);

    var newUsuarios = [...usuarios];
    setUsuarios(newUsuarios);

    return usuarioSqliteRepository.delete(id);
  }
}
