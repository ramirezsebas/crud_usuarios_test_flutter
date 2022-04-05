import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../modules/usuarios/presentation/usuario-list/usuario_list_change_notifier.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.sync_disabled_outlined),
          label: 'Local',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.sync_outlined),
          label: 'Remoto',
        ),
      ],
      currentIndex: context.watch<UsuarioListChangeNotifier>().tabIndex,
      onTap: context.read<UsuarioListChangeNotifier>().setTabIndex,
    );
  }
}
