class UserModel {
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String password;

  UserModel({
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'] ?? "",
      email: json['email'] ?? "",
      firstName: json['firstName'] ?? "",
      lastName: json['lastName'] ?? "",
      password: json['password'] ?? "",
    );
  }

  UserModel copywith({
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    String? password,
  }) {
    return UserModel(
      username: username ?? this.username,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      password: password ?? this.password,
    );
  }
}