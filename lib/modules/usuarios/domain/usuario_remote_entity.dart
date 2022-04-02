class UsuarioRemoteEntity {
  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  UsuarioRemoteEntity({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory UsuarioRemoteEntity.fromJson(Map<String, dynamic> json) {
    return UsuarioRemoteEntity(
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
