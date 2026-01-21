// To parse this JSON data, do
//
//     final technicianProfile = technicianProfileFromJson(jsonString);



class TechnicianProfile {
  final Data data;

  TechnicianProfile({required this.data});

  factory TechnicianProfile.fromJson(Map<String, dynamic> json) {
    return TechnicianProfile(
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  final String id;
  final Role role;
  final String firstName;
  final String lastName;
  final String email;
  final String mobile; // ✅ String (safe)
  final String gender;
  final bool status;
  final String? image; // ✅ nullable

  Data({
    required this.id,
    required this.role,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.gender,
    required this.status,
    this.image,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['_id'] ?? '',
      role: Role.fromJson(json['role']),
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'].toString(), // 🔥 VERY IMPORTANT
      gender: json['gender'] ?? '',
      status: json['status'] ?? false,
      image: json['image'],
    );
  }
}

class Role {
  final String id;
  final String skill;

  Role({required this.id, required this.skill});

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['_id'] ?? '',
      skill: json['skill'] ?? '',
    );
  }
}
