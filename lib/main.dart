import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'package:test_itti_flutter/modules/usuarios/presentation/usuario-form/usuario_form_change_notifier.dart';
import 'package:test_itti_flutter/modules/usuarios/presentation/usuario-list/usuario_list_change_notifier.dart';
import 'package:test_itti_flutter/modules/usuarios/presentation/usuario-list/usuario_list_page.dart';
import 'package:test_itti_flutter/shared/infrastructure/base_sqlite_repository.dart';
import 'package:test_itti_flutter/shared/infrastructure/get_it_di.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await GetStorage.init();

    setup();

    await initLocalDatabase();

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => UsuarioListChangeNotifier(),
          ),
          ChangeNotifierProvider(
            create: (_) => UsuarioFormChangeNotifier(),
          ),
        ],
        child: const MyApp(),
      ),
    );
  }, (error, stackTrace) {
    print("Error :  $error");
    print("StackTrace :  $stackTrace");
  });
}

Future<void> initLocalDatabase() async {
  await BaseSqliteRepository.db.database;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'CRUD Usuarios',
      debugShowCheckedModeBanner: false,
      home: UsuarioListPage(),
    );
  }
}
