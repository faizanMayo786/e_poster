
import 'dart:convert';
// User Model
class UserModel {
  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phoneNumber,
  });

  String firstName;
  String lastName;
  String email;
  String password;
  String phoneNumber;

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toMap() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "phoneNumber": phoneNumber,
      };
}
