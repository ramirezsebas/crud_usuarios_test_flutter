import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:test_itti_flutter/modules/usuarios/presentation/usuario-list/usuario_list_change_notifier.dart';
import 'package:test_itti_flutter/modules/usuarios/presentation/usuario-list/widgets/main_buttons.dart';
import 'package:test_itti_flutter/modules/usuarios/presentation/usuario-list/widgets/usuario_list.dart';
import 'package:test_itti_flutter/shared/widgets/custom_bottom_navigation.dart';

class UsuarioListPage extends StatelessWidget {
  const UsuarioListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: const Text('Usuarios'),
          leading: SizedBox.fromSize(),
          centerTitle: true,
        ),
        floatingActionButton:
            context.watch<UsuarioListChangeNotifier>().tabIndex == 1
                ? null
                : const MainButtons(),
        bottomNavigationBar: const CustomBottomNavigation(),
        body: Column(
          children: [
            Expanded(
              child: IndexedStack(
                index: context.watch<UsuarioListChangeNotifier>().tabIndex,
                children: [
                  const UsuarioList(
                    isRemote: false,
                  ),
                  RefreshIndicator(
                    onRefresh: () {
                      try {
                        return context
                            .read<UsuarioListChangeNotifier>()
                            .getAllUsuarios(isRemote: true);
                      } catch (e) {
                        print(e);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Error al traer a los usuarios'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                      return Future.value();
                    },
                    child: const UsuarioList(
                      isRemote: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
