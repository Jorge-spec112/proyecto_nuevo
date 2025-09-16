class User {
  final String name;
  final String email;

  User(this.name, this.email);

  // Constructor desde JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['name'] ?? '', json['email'] ?? '');
  }

  // Convertir a JSON (por si necesitas enviar datos a una API)
  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email};
  }
}
