class UsuarioEntity {
  int? id;
  String? nombre;
  DateTime? fechaNacimiento;
  String? sexo;

  UsuarioEntity({
    this.id,
    this.nombre,
    this.fechaNacimiento,
    this.sexo,
  });

  factory UsuarioEntity.fromJson(Map<String, dynamic> json) {
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
