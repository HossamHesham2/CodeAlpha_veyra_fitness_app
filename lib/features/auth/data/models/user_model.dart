class UserModel {
  final String fullName;
  final String email;

  UserModel({required this.fullName, required this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(fullName: json['fullName'] as String, email: json['email'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'fullName': fullName, 'email': email};
  }
}
