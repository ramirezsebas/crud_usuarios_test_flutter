import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:test_itti_flutter/modules/usuarios/domain/usuario_entity.dart';
import 'package:test_itti_flutter/modules/usuarios/presentation/usuario-form/usuario_form_page.dart';
import 'package:test_itti_flutter/modules/usuarios/presentation/usuario-list/usuario_list_change_notifier.dart';
import 'package:test_itti_flutter/modules/usuarios/presentation/usuario-list/widgets/usuario_card_body.dart';
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
            if (myUsuarios.isEmpty &&
                !context.watch<UsuarioListChangeNotifier>().loading)
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
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
        if (!widget.isRemote)
          Positioned(
            right: 0,
            bottom: 10,
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      height: 60,
                      shape: const CircleBorder(),
                      color: Colors.red,
                      onPressed: () {
                        context.read<UsuarioListChangeNotifier>().deleteAll();
                      },
                      child: const Icon(
                        Icons.delete_forever_outlined,
                        color: Colors.white,
                      ),
                    ),
                    MaterialButton(
                      height: 60,
                      elevation: 5.0,
                      shape: const CircleBorder(),
                      color: Colors.blue,
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
                      child: const Icon(
                        Icons.add_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        if (context.watch<UsuarioListChangeNotifier>().loading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
