import 'package:flutter/material.dart';
import 'package:test_itti_flutter/modules/usuarios/presentation/usuario-form/usuario_form_page.dart';

class UsuarioListHeader extends StatelessWidget {
  const UsuarioListHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UsuarioFormPage(
                      edit: false,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text("Agregar")),
        ],
      ),
    );
  }
}
