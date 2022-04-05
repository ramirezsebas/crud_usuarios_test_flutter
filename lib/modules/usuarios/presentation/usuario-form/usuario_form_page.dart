import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'package:test_itti_flutter/modules/usuarios/infrastructure/sqlite_usuario_respository.dart';
import 'package:test_itti_flutter/modules/usuarios/presentation/usuario-form/usuario_form_change_notifier.dart';
import 'package:test_itti_flutter/modules/usuarios/presentation/usuario-form/widgets/usuario_form.dart';
import 'package:test_itti_flutter/modules/usuarios/presentation/usuario-list/usuario_list_page.dart';
import 'package:test_itti_flutter/shared/widgets/custom_card.dart';

class UsuarioFormPage extends StatefulWidget {
  const UsuarioFormPage({Key? key, required this.edit}) : super(key: key);
  final bool edit;

  @override
  State<UsuarioFormPage> createState() => _UsuarioFormPageState();
}

class _UsuarioFormPageState extends State<UsuarioFormPage> {
  final SqliteUsuarioRepository usuarioSqliteRepository =
      GetIt.I<SqliteUsuarioRepository>();

  @override
  void initState() {
    super.initState();
    if (!widget.edit) {
      context.read<UsuarioFormChangeNotifier>().clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("¿Estás seguro?"),
                  content: const Text("Se perderán los datos"),
                  actions: [
                    TextButton(
                      child: const Text("Cancelar"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text("Aceptar"),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            CustomCard(
              padding: 20,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      widget.edit ? "Modificar Usuario" : "Crear Usuario",
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    UsuarioForm(edit: widget.edit),
                  ],
                ),
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
