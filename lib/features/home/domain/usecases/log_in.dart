import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/basic_user.dart';
import '../repositories/home_repository.dart';

class LogIn {
  final HomeRepository repository;
  LogIn(this.repository);

  Future<Either<Failure, UserLogIn?>?> call() async {
    return repository.logIn();
  }
}
