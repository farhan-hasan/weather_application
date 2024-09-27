class UserModel {
  String email;
  String uID;
  String deviceToken;

  UserModel({
    required this.email,
    required this.uID,
    required this.deviceToken,
  });

  // Method to convert a User object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'uID': uID,
      'deviceToken': deviceToken,
    };
  }

  // Factory constructor to create a User object from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      uID: json['uID'],
      deviceToken: json['deviceToken'],
    );
  }
}
