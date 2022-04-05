import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

import 'package:test_itti_flutter/modules/usuarios/domain/usuario_entity.dart';
import 'package:test_itti_flutter/modules/usuarios/infrastructure/dio_usuario_repository.dart';
import 'package:test_itti_flutter/modules/usuarios/infrastructure/sqlite_usuario_respository.dart';

class UsuarioListChangeNotifier extends ChangeNotifier {
  List<UsuarioEntity> usuarios = [];
  bool loading = false;

  final SqliteUsuarioRepository usuarioSqliteRepository =
      GetIt.I<SqliteUsuarioRepository>();
  final DioUsuarioRepository usuarioDioRepository =
      GetIt.I<DioUsuarioRepository>();

  UsuarioListChangeNotifier();

  setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

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
    loading = true;
    usuarios = [];
    var localUsuarios = await usuarioSqliteRepository.getAll();
    setUsuarios(localUsuarios);
    loading = false;
    return localUsuarios;
  }

  Future<List<UsuarioEntity>> getAllUsuariosRemote() async {
    loading = true;
    usuarios = [];
    var remoteUsuarios = await usuarioDioRepository.getAll();
    setUsuarios(remoteUsuarios);
    loading = false;
    return remoteUsuarios;
  }

  Future<List<UsuarioEntity>> getAllUsuariosRemoteOrCached() async {
    loading = true;
    usuarios = [];
    var hasCachedUsuario = GetStorage().hasData('usuarios');
    if (!hasCachedUsuario) {
      var remoteUsuarios = await usuarioDioRepository.getAll();
      GetStorage().write('time', DateTime.now().toString());
      GetStorage().write('usuarios',
          jsonEncode(remoteUsuarios.map((u) => u.toLocalJson()).toList()));
      setUsuarios(remoteUsuarios);
      loading = false;
      return remoteUsuarios;
    }

    var now = DateTime.now();

    var time = DateTime.parse(await GetStorage().read('time'));

    var diff = now.difference(time);

    if (diff.inMinutes > 5) {
      var remoteUsuarios = await usuarioDioRepository.getAll();
      GetStorage().write('time', DateTime.now().toString());
      GetStorage().write('usuarios',
          jsonEncode(remoteUsuarios.map((u) => u.toLocalJson()).toList()));
      setUsuarios(remoteUsuarios);
      loading = false;
      return remoteUsuarios;
    } else {
      var cachedUsuarios = jsonDecode(await GetStorage().read('usuarios'));
      List<UsuarioEntity> remoteUsuarios = List.from(
          cachedUsuarios.map((u) => UsuarioEntity.fromLocalJson(u)).toList());

      setUsuarios(remoteUsuarios);
      loading = false;
      return remoteUsuarios;
    }
  }

  Future<UsuarioEntity?> getOneUsuario(String id) async {
    var usuario = await usuarioSqliteRepository.getOne(id);
    return usuario;
  }

  Future<int> delete(int id) async {
    var deleted = await usuarioSqliteRepository.delete(id);
    if (deleted > 0) {
      var index = usuarios.indexWhere((u) => u.id == id);
      usuarios.removeAt(index);
      var newUsuarios = [...usuarios];
      setUsuarios(newUsuarios);
    }
    return deleted;
  }

  Future<int> deleteAll() async {
    var deleted = await usuarioSqliteRepository.deleteAll();
    if (deleted > 0) {
      usuarios = [];
      setUsuarios([]);
    }
    return deleted;
  }
}
