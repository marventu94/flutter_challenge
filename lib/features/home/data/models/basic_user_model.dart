class BasicUserModel {
  String username;
  String password;

  BasicUserModel({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }

  factory BasicUserModel.empty() {
    return BasicUserModel(username: '', password: '');
  }
}
