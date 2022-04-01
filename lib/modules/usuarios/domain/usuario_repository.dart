import 'package:test_itti_flutter/modules/usuarios/domain/usuario_entity.dart';

abstract class UsuarioRepository {
  Future<UsuarioEntity> getOne(String id);
  Future<List<UsuarioEntity>> getAll();
}
