import 'package:flutter/material.dart';
import 'package:test_itti_flutter/shared/infrastructure/base_sqlite_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final sqliteRepository = BaseSqliteRepository();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
      ),
    );
  }
}
