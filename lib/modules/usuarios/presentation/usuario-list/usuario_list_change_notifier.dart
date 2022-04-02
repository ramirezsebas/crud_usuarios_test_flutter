import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'package:test_itti_flutter/modules/usuarios/domain/usuario_entity.dart';
import 'package:test_itti_flutter/modules/usuarios/domain/usuario_remote_entity.dart';
import 'package:test_itti_flutter/modules/usuarios/infrastructure/dio_usuario_repository.dart';
import 'package:test_itti_flutter/modules/usuarios/infrastructure/sqlite_usuario_respository.dart';

class UsuarioListChangeNotifier extends ChangeNotifier {
  List<UsuarioEntity> usuarios = [];
  final SqliteUsuarioRepository usuarioSqliteRepository =
      GetIt.I<SqliteUsuarioRepository>();
  final DioUsuarioRepository usuarioDioRepository =
      GetIt.I<DioUsuarioRepository>();

  UsuarioListChangeNotifier();

  Future<int> addUsuario(UsuarioEntity usuario) async {
    notifyListeners();
    return usuarioSqliteRepository.create(usuario);
  }

  Future<int> updateUsuario(UsuarioEntity usuario) {
    notifyListeners();
    return usuarioSqliteRepository.update(usuario);
  }

  Future<List<UsuarioEntity>> getAllUsuariosLocal() async {
    return usuarioSqliteRepository.getAll();
  }

  Future<List<UsuarioRemoteEntity>> getAllUsuariosRemote() async {
    return usuarioDioRepository.getAll();
  }

  Future<UsuarioEntity?> getOneUsuario(String id) async {
    return usuarioSqliteRepository.getOne(id);
  }

  Future<void> delete(int id) {
    notifyListeners();
    return usuarioSqliteRepository.delete(id);
  }
}
