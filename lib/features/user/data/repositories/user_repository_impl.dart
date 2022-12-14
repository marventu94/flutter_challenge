import 'package:dartz/dartz.dart';

import '../../../../core/connection/network_info.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/string/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/users_local_data_source.dart';
import '../datasources/users_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UsersRemoteDataSource remoteDataSource;
  final UsersLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<User>?>>? getUsers() async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteUsers = await remoteDataSource.getAllUsers();
        localDataSource.cacheUsers(remoteUsers);
        return Right(remoteUsers);
      } on ServerException {
        return Left(
          ServerFailure(errorMessage: FailuresMessage.offlineFailureMessage),
        );
      }
    } else {
      try {
        final localUsers = await remoteDataSource.getAllUsers();
        return Right(localUsers);
      } on CacheException {
        return Left(
          CacheFailure(errorMessage: FailuresMessage.emptyCacheFailureMessage),
        );
      }
    }
  }
}
