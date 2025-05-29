class RegisterModel {
  late String name;
  late String email;
  late String password;
  late String role;

  RegisterModel({required this.name, required this.email, required this.password, required this.role});

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'password': password, 'role': role.toUpperCase()};
  }
}
