import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:test_itti_flutter/modules/usuarios/domain/usuario_entity.dart';
import 'package:test_itti_flutter/modules/usuarios/presentation/usuario-form/usuario_form_change_notifier.dart';
import 'package:test_itti_flutter/modules/usuarios/presentation/usuario-list/usuario_list_change_notifier.dart';
import 'package:test_itti_flutter/shared/utils/date_format_utils.dart';

class UsuarioForm extends StatefulWidget {
  const UsuarioForm({Key? key, required this.edit}) : super(key: key);
  final bool edit;
  @override
  State<UsuarioForm> createState() => _UsuarioFormState();
}

class _UsuarioFormState extends State<UsuarioForm> {
  TextEditingController dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    dateController.text = DateFormatUtils.formatDate(
        context.read<UsuarioFormChangeNotifier>().fechaNacimiento);
  }

  @override
  Widget build(BuildContext context) {
    List<String> sexos = context.read<UsuarioFormChangeNotifier>().sexos;
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                    ),
                    initialValue:
                        context.read<UsuarioFormChangeNotifier>().nombre,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'El nombre es requerido';
                      }

                      return null;
                    },
                    onChanged:
                        context.read<UsuarioFormChangeNotifier>().changeNombre,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    readOnly: true,
                    controller: dateController,
                    decoration: const InputDecoration(
                      labelText: 'Fecha de Nacimiento',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'La fecha de nacimiento es requerida';
                      }
                      return null;
                    },
                    onTap: () async {
                      await _changeDate(context);
                    },
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value:
                        context.read<UsuarioFormChangeNotifier>().selectedSexo,
                    items: sexos
                        .map((e) => DropdownMenuItem(child: Text(e), value: e))
                        .toList(),
                    onChanged:
                        context.read<UsuarioFormChangeNotifier>().changeSexo,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await _saveUsuario(context);
                        } catch (e) {
                          print(e);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Error al guardar el usuario'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    icon: const Icon(Icons.add),
                    label: Text(widget.edit ? "Modificar" : "Agregar"),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
        if (context.watch<UsuarioFormChangeNotifier>().loading)
          const Center(child: CircularProgressIndicator())
      ],
    );
  }

  Future<void> _changeDate(BuildContext context) async {
    var fecha = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 15),
      firstDate: DateTime(1700),
      lastDate: DateTime(DateTime.now().year - 15),
    );

    if (fecha != null) {
      context.read<UsuarioFormChangeNotifier>().changeFechaNacimiento(fecha);
      dateController.text = DateFormatUtils.formatDate(fecha);
    }
  }

  Future<void> _saveUsuario(BuildContext context) async {
    context.read<UsuarioFormChangeNotifier>().changeLoading(true);
    var usuario = UsuarioEntity(
      id: context.read<UsuarioFormChangeNotifier>().id,
      nombre: context.read<UsuarioFormChangeNotifier>().nombre,
      fechaNacimiento:
          context.read<UsuarioFormChangeNotifier>().fechaNacimiento,
      sexo: context
          .read<UsuarioFormChangeNotifier>()
          .extractFirstLetterSelectedSexo(),
    );

    try {
      int createdOrUpdatedUser;
      if (!widget.edit) {
        createdOrUpdatedUser =
            await context.read<UsuarioListChangeNotifier>().addUsuario(
                  usuario,
                );
      } else {
        createdOrUpdatedUser =
            await context.read<UsuarioListChangeNotifier>().updateUsuario(
                  usuario,
                );
      }
      if (createdOrUpdatedUser > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(widget.edit ? 'Usuario Modificado' : 'Usuario creado'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al crear el usuario'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al guardar el usuario'),
          backgroundColor: Colors.red,
        ),
      );
    }
    context.read<UsuarioFormChangeNotifier>().changeNombre("");
    context.read<UsuarioFormChangeNotifier>().changeLoading(false);
  }
}
