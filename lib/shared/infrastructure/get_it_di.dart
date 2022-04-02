import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:test_itti_flutter/modules/usuarios/infrastructure/dio_usuario_repository.dart';
import 'package:test_itti_flutter/modules/usuarios/infrastructure/sqlite_usuario_respository.dart';
import 'package:test_itti_flutter/shared/infrastructure/base_sqlite_repository.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<BaseSqliteRepository>(BaseSqliteRepository.db);
  getIt.registerLazySingleton(
      () => SqliteUsuarioRepository(BaseSqliteRepository.db.instance!));
  getIt.registerLazySingleton(() => DioUsuarioRepository(Dio()));
}
