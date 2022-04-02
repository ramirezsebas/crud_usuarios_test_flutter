import 'package:flutter/material.dart';
import 'package:test_itti_flutter/modules/usuarios/domain/usuario_remote_entity.dart';

class UsuarioRemoteCardBody extends StatelessWidget {
  const UsuarioRemoteCardBody({
    Key? key,
    required this.usuario,
  }) : super(key: key);

  final UsuarioRemoteEntity usuario;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(usuario.avatar),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                "Software Developer",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const Divider(),
        Wrap(
          alignment: WrapAlignment.start,
          children: [
            Text("Nombre: " + usuario.firstName + " " + usuario.lastName),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          alignment: WrapAlignment.start,
          children: [
            Text("Email: " + usuario.email),
          ],
        ),
      ],
    );
  }
}
