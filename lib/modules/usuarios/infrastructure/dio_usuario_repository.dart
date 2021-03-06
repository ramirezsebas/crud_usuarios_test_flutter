import 'package:dio/dio.dart';

import 'package:test_itti_flutter/modules/usuarios/domain/usuario_entity.dart';

class DioUsuarioRepository {
  Dio dio;
  final String _baseUrl = "https://reqres.in";

  DioUsuarioRepository(this.dio);

  Future<List<UsuarioEntity>> getAll() async {
    final url = "$_baseUrl/api/users";
    var resp = await dio.get(url);
    var usuarioData = resp.data["data"] as List;
    return usuarioData
        .map((usuario) => UsuarioEntity.fromRemoteJson(usuario))
        .toList();
  }
}
