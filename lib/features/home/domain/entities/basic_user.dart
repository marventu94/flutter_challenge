import 'package:equatable/equatable.dart';

class UserLogIn extends Equatable{
  final String username;
  final String password;


  const UserLogIn({
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [];
}