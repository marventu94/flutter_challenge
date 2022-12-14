import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/basic_user.dart';

abstract class HomeRepository {
  Future<Either<Failure, UserLogIn?>>? logIn();
}
