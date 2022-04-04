import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_itti_flutter/modules/usuarios/presentation/usuario-list/usuario_list_change_notifier.dart';

import 'package:test_itti_flutter/modules/usuarios/presentation/usuario-list/widgets/usuario_list.dart';
import 'package:test_itti_flutter/modules/usuarios/presentation/usuario-list/widgets/usuario_tab_view.dart';

class UsuarioListPage extends StatelessWidget {
  const UsuarioListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text('Usuarios'),
            leading: SizedBox.fromSize(),
            centerTitle: true,
          ),
          body: Column(
            children: const [
              UsuarioTabView(),
              Expanded(
                child: TabBarView(
                  children: [
                    UsuarioList(
                      isRemote: false,
                    ),
                    UsuarioList(
                      isRemote: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
