import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:test_itti_flutter/modules/usuarios/domain/usuario_entity.dart';
import 'package:test_itti_flutter/modules/usuarios/presentation/usuario-list/usuario_list_change_notifier.dart';
import 'package:test_itti_flutter/modules/usuarios/presentation/usuario-list/widgets/usuario_card_body.dart';
import 'package:test_itti_flutter/modules/usuarios/presentation/usuario-list/widgets/usuario_list_header.dart';
import 'package:test_itti_flutter/shared/widgets/custom_card.dart';
import 'package:test_itti_flutter/shared/widgets/no_data.dart';

class UsuarioList extends StatefulWidget {
  const UsuarioList({Key? key, required this.isRemote}) : super(key: key);

  final bool isRemote;

  @override
  State<UsuarioList> createState() => _UsuarioListState();
}

class _UsuarioListState extends State<UsuarioList> {
  @override
  void initState() {
    super.initState();
    _loadUsuarios();
  }

  void _loadUsuarios() {
    if (widget.isRemote) {
      context.read<UsuarioListChangeNotifier>().getAllUsuariosRemote();
    } else {
      context.read<UsuarioListChangeNotifier>().getAllUsuariosLocal();
    }
  }

  @override
  Widget build(BuildContext context) {
    var myUsuarios = context.watch<UsuarioListChangeNotifier>().usuarios;
    return Stack(
      children: [
        Column(
          children: [
            if (!widget.isRemote) const UsuarioListHeader(),
            if (myUsuarios.isEmpty &&
                !context.watch<UsuarioListChangeNotifier>().loading)
              const NoData(label: "No Hay Usuarios"),
            if (myUsuarios.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: myUsuarios.length,
                  itemBuilder: (context, index) {
                    UsuarioEntity usuario = myUsuarios[index];
                    return CustomCard(
                      child: UsuarioCardBody(
                        usuario: usuario,
                        isRemote: widget.isRemote,
                      ),
                      padding: 15,
                    );
                  },
                ),
              ),
          ],
        ),
        if (context.watch<UsuarioListChangeNotifier>().loading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
