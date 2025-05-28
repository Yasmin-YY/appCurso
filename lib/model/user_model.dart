class UserModel {
  final int? id;
  final String email;
  final String password;
  UserModel({this.id, required this.email, required this.password});
  Map toMap() {
    return {'id': id, 'email': email, 'password': password};
  }

  static UserModel fromMap(Map map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      password: map['password'],
    );
  }
}
