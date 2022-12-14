import '../../domain/entities/basic_user.dart';

class BasicUserModel extends UserLogIn {
  const BasicUserModel({
    required super.username,
    required super.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
