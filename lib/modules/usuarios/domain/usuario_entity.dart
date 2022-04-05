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

    if (!json.containsKey('avatar')) {
      throw Exception('El json no contiene la llave avatar');
    }

    if (!json.containsKey('email')) {
      throw Exception('El json no contiene la llave email');
    }

    return UsuarioEntity(
      id: json['id'],
      nombre: (json['first_name'] + " " + json['last_name']) ?? json['nombre'],
      email: json['email'],
      avatar: json['avatar'],
    );
  }

  factory UsuarioEntity.fromLocalJson(Map<String, dynamic> json) {
    if (!json.containsKey('nombre')) {
      throw Exception('El json no contiene la llave nombre');
    }

    String? sexo = json['sexo'];
    if (sexo != null) {
      if (sexo.length != 1) {
        throw Exception('El sexo debe ser un caracter');
      }
    }

    return UsuarioEntity(
      id: json['id'],
      nombre: json['nombre'],
      fechaNacimiento: json['fechaNacimiento'] != null
          ? DateTime.tryParse(json['fechaNacimiento'])
          : null,
      email: json['email'],
      sexo: json['sexo'],
    );
  }

  Map<String, dynamic> toLocalJson() {
    return {
      'id': id,
      'nombre': nombre,
      'fechaNacimiento': fechaNacimiento?.toIso8601String(),
      'email': email,
      'sexo': sexo,
    };
  }

  Map<String, dynamic> toRemoteJson() {
    var myCapitalIndex = nombre.lastIndexOf(RegExp(r'[A-Z]'));
    var myCapital = nombre[myCapitalIndex];
    var replaced =
        nombre.replaceRange(myCapitalIndex, myCapitalIndex, " $myCapital");

    return {
      'id': id,
      'nombre': replaced.split(' ')[0],
      'last_name': replaced.split(' ')[1],
      'avatar': avatar,
      'email': email,
    };
  }
}
