class UsuarioEntity {
  int? id;
  String nombre;
  DateTime? fechaNacimiento;
  String? sexo;
  String? email;
  String? avatar;

  UsuarioEntity({
    this.id,
    required this.nombre,
    this.email,
    this.avatar,
    this.fechaNacimiento,
    this.sexo,
  });

  factory UsuarioEntity.fromRemoteJson(Map<String, dynamic> json) {
    if (!json.containsKey('id')) {
      throw Exception('El json no contiene la llave id');
    }

    if (!json.containsKey('first_name')) {
      throw Exception('El json no contiene la llave first_name');
    }

    if (!json.containsKey('last_name')) {
      throw Exception('El json no contiene la llave last_name');
    }

    if (!json.containsKey('avatar')) {
      throw Exception('El json no contiene la llave avatar');
    }

    if (!json.containsKey('email')) {
      throw Exception('El json no contiene la llave email');
    }

    return UsuarioEntity(
      id: json['id'],
      nombre: json['first_name'] + json['last_name'],
      email: json['email'],
      avatar: json['avatar'],
    );
  }

  factory UsuarioEntity.fromLocalJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toLocalJson() {
    return {
      'id': id,
      'nombre': nombre,
      'fechaNacimiento': fechaNacimiento?.toIso8601String(),
      'sexo': sexo,
    };
  }

  Map<String, dynamic> toRemoteJson() {
    return {
      'id': id,
      'first_name': nombre.split(' ')[0],
      'last_name': nombre.split(' ')[1],
      'avatar': avatar,
      'email': email,
    };
  }
}
