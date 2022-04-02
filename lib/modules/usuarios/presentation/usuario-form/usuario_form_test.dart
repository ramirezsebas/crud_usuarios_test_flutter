import 'package:flutter_test/flutter_test.dart';
import 'package:test_itti_flutter/modules/usuarios/domain/usuario_entity.dart';
import 'package:test_itti_flutter/modules/usuarios/presentation/usuario-form/usuario_form_change_notifier.dart';

void main() {
  group('Formulario de Usuario', () {
    test('Debe ser capaz de crear un usuario', () {
      var usuarioChangeNotifier = UsuarioFormChangeNotifier();
      var currentDate = DateTime.now();
      usuarioChangeNotifier.initUsuario(UsuarioEntity(
        id: 1,
        nombre: 'Juan',
        sexo: 'Masculino',
        fechaNacimiento: currentDate,
      ));

      expect(usuarioChangeNotifier.id, 1);
      expect(usuarioChangeNotifier.nombre, "Juan");
      expect(usuarioChangeNotifier.selectedSexo, "Masculino");
      expect(usuarioChangeNotifier.fechaNacimiento, currentDate);
      expect(true, isTrue);
    });
  });
}
