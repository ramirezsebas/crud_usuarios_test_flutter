import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_itti_flutter/modules/usuarios/domain/usuario_entity.dart';
import 'package:test_itti_flutter/modules/usuarios/presentation/usuario-list/usuario_list_change_notifier.dart';

class UsuarioListRemote extends StatefulWidget {
  const UsuarioListRemote({
    Key? key,
  }) : super(key: key);

  @override
  State<UsuarioListRemote> createState() => _UsuarioListRemoteState();
}

class _UsuarioListRemoteState extends State<UsuarioListRemote>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UsuarioRemoteEntity>>(
      future: context.read<UsuarioListChangeNotifier>().getAllUsuariosRemote(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/empty-box.png'),
              const Text('No hay usuarios'),
            ],
          );
        }
        var allUsuarios = snapshot.data;

        if (allUsuarios == null) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/empty-box.png'),
              const Text('No hay usuarios'),
            ],
          );
        }

        if (allUsuarios.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/empty-box.png'),
              const Text('No hay usuarios'),
            ],
          );
        }

        return ListView.builder(
          itemCount: allUsuarios.length,
          itemBuilder: (context, index) {
            UsuarioRemoteEntity usuario = allUsuarios[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(usuario.avatar),
              ),
              title: Text(usuario.firstName + " " + usuario.lastName),
              subtitle: Text(usuario.email),
            );
          },
        );
      },
    );
  }
}
