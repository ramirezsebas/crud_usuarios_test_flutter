import 'package:dio/dio.dart';
import 'package:test_itti_flutter/modules/usuarios/domain/usuario_entity.dart';

class DioUsuarioRepository {
  Dio dio;
  final String _baseUrl = "https://reqres.in";

  DioUsuarioRepository(this.dio);

  Future<List<RemoteUsuarioEntity>> getAll() {
    final url = "$_baseUrl/api/users";
    return dio.get(url).then((response) {
      return response.data
          .map((usuario) => RemoteUsuarioEntity.fromJson(usuario))
          .toList();
    });
  }
}
