import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:test_itti_flutter/modules/usuarios/domain/usuario_entity.dart';

import 'package:test_itti_flutter/modules/usuarios/presentation/usuario-list/usuario_list_change_notifier.dart';
import 'package:test_itti_flutter/modules/usuarios/presentation/usuario-list/widgets/usuario_list_header.dart';
import 'package:test_itti_flutter/modules/usuarios/presentation/usuario-list/widgets/usuario_card_body.dart';
import 'package:test_itti_flutter/shared/widgets/custom_card.dart';
import 'package:test_itti_flutter/shared/widgets/no_data.dart';

class UsuarioList extends StatefulWidget {
  const UsuarioList({Key? key, required this.isRemote}) : super(key: key);

  final bool isRemote;

  @override
  State<UsuarioList> createState() => _UsuarioListState();
}

class _UsuarioListState extends State<UsuarioList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!widget.isRemote) const UsuarioListHeader(),
        Expanded(
          child: FutureBuilder<List<UsuarioEntity>>(
            future: widget.isRemote
                ? context
                    .read<UsuarioListChangeNotifier>()
                    .getAllUsuariosRemote()
                : context
                    .read<UsuarioListChangeNotifier>()
                    .getAllUsuariosLocal(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (!snapshot.hasData) {
                return const NoData(
                  label: "No hay Usuarios",
                );
              }
              var allUsuarios = snapshot.data as List<UsuarioEntity>;

              if (allUsuarios == null) {
                return const NoData(
                  label: "No hay Usuarios",
                );
              }

              if (allUsuarios.isEmpty) {
                return const NoData(
                  label: "No hay Usuarios",
                );
              }
              if (!widget.isRemote) {
                var usus = context.read<UsuarioListChangeNotifier>().usuarios;
                if (usus.isEmpty) {
                  return const NoData(
                    label: "No hay Usuarios",
                  );
                }
              }

              return ListView.builder(
                itemCount: !widget.isRemote
                    ? context.watch<UsuarioListChangeNotifier>().usuarios.length
                    : allUsuarios.length,
                itemBuilder: (context, index) {
                  UsuarioEntity usuario = !widget.isRemote
                      ? context
                          .watch<UsuarioListChangeNotifier>()
                          .usuarios[index]
                      : allUsuarios[index];
                  return CustomCard(
                    child: UsuarioCardBody(
                      usuario: usuario,
                      isRemote: widget.isRemote,
                    ),
                    padding: 15,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
