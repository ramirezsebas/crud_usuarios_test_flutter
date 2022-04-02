import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_itti_flutter/modules/usuarios/domain/usuario_entity.dart';
import 'package:test_itti_flutter/modules/usuarios/presentation/usuario-form/usuario_form_change_notifier.dart';
import 'package:test_itti_flutter/modules/usuarios/presentation/usuario-form/usuario_form_page.dart';
import 'package:test_itti_flutter/modules/usuarios/presentation/usuario-list/usuario_list_change_notifier.dart';
import 'package:test_itti_flutter/shared/utils/date_format_utils.dart';

class UsuarioListLocal extends StatefulWidget {
  const UsuarioListLocal({
    Key? key,
  }) : super(key: key);

  @override
  State<UsuarioListLocal> createState() => _UsuarioListLocalState();
}

class _UsuarioListLocalState extends State<UsuarioListLocal>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
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
        ),
        Expanded(
          child: FutureBuilder<List<UsuarioEntity>>(
              initialData: const [],
              future: context
                  .read<UsuarioListChangeNotifier>()
                  .getAllUsuariosLocal(),
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

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: allUsuarios.length,
                    itemBuilder: (context, index) {
                      UsuarioEntity usuario = allUsuarios[index];
                      return ListTile(
                        visualDensity: VisualDensity.compact,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("¿Qué desea hacer?"),
                                content: Text(
                                    "Puede editar o eliminar el usuario ${usuario.nombre}"),
                                actions: [
                                  TextButton(
                                    child: const Text("Editar"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                          context
                                              .read<UsuarioFormChangeNotifier>()
                                              .initUsuario(usuario);

                                          return const UsuarioFormPage(
                                            edit: true,
                                          );
                                        }),
                                      );
                                      setState(() {});
                                    },
                                  ),
                                  TextButton(
                                    child: const Text("Eliminar"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      context
                                          .read<UsuarioListChangeNotifier>()
                                          .delete(usuario.id!);
                                      setState(() {});
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        leading: const CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        title: Text(
                          usuario.nombre,
                        ),
                        subtitle: Text(
                          DateFormatUtils.formatDate(usuario.fechaNacimiento),
                        ),
                        isThreeLine: true,
                        trailing: Text(
                          usuario.sexo,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
        ),
      ],
    );
  }
}
