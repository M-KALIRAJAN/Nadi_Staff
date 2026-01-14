// To parse this JSON data, do
//
//     final technicianProfile = technicianProfileFromJson(jsonString);

import 'dart:convert';

TechnicianProfile technicianProfileFromJson(String str) =>
    TechnicianProfile.fromJson(json.decode(str));

String technicianProfileToJson(TechnicianProfile data) =>
    json.encode(data.toJson());

class TechnicianProfile {
  Data data;

  TechnicianProfile({required this.data});

  factory TechnicianProfile.fromJson(Map<String, dynamic> json) =>
      TechnicianProfile(data: Data.fromJson(json["data"]));

  Map<String, dynamic> toJson() => {"data": data.toJson()};
}

class Data {
  String id;
  Role role;
  String firstName;
  String lastName;
  String email;
  int mobile;
  String gender;
  String password;
  bool status;
  dynamic resetPasswordToken;
  dynamic resetPasswordExpires;
  int v;

  Data({
    required this.id,
    required this.role,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.gender,
    required this.password,
    required this.status,
    required this.resetPasswordToken,
    required this.resetPasswordExpires,
    required this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    role: Role.fromJson(json["role"]),
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    mobile: json["mobile"],
    gender: json["gender"],
    password: json["password"],
    status: json["status"],
    resetPasswordToken: json["resetPasswordToken"],
    resetPasswordExpires: json["resetPasswordExpires"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "role": role.toJson(),
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "mobile": mobile,
    "gender": gender,
    "password": password,
    "status": status,
    "resetPasswordToken": resetPasswordToken,
    "resetPasswordExpires": resetPasswordExpires,
    "__v": v,
  };
}

class Role {
  String id;
  String skill;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Role({
    required this.id,
    required this.skill,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["_id"],
    skill: json["skill"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "skill": skill,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
