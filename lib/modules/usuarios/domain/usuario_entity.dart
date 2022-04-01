class UsuarioEntity {
  int id;
  String nombre;
  DateTime fechaNacimiento;
  String sexo;

  UsuarioEntity({
    required this.id,
    required this.nombre,
    required this.fechaNacimiento,
    required this.sexo,
  });

  factory UsuarioEntity.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('id')) {
      throw Exception('El json no contiene la llave id');
    }

    if (!json.containsKey('nombre')) {
      throw Exception('El json no contiene la llave nombre');
    }

    if (!json.containsKey('fechaNacimiento')) {
      throw Exception('El json no contiene la llave fechaNacimiento');
    }

    if (!json.containsKey('sexo')) {
      throw Exception('El json no contiene la llave sexo');
    }
    
    String sexo = json['sexo'];

    if (sexo.length != 1) {
      throw Exception('El sexo debe ser un caracter');
    }
    return UsuarioEntity(
      id: json['id'],
      nombre: json['nombre'],
      fechaNacimiento: DateTime.parse(json['fechaNacimiento']),
      sexo: json['sexo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'fechaNacimiento': fechaNacimiento,
      'sexo': sexo,
    };
  }
}

class RemoteUsuarioEntity {
  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  RemoteUsuarioEntity({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory RemoteUsuarioEntity.fromJson(Map<String, dynamic> json) {
    return RemoteUsuarioEntity(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'avatar': avatar,
    };
  }
}
