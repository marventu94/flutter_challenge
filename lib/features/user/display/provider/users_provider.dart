import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/connection/network_info.dart';
import '../../../../core/errors/failures.dart';
import '../../data/datasources/users_local_data_source.dart';
import '../../data/datasources/users_remote_data_source.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/entities/user.dart';

class UsersProvider extends ChangeNotifier {
  List<User>? users;
  Failure? failure;
  bool? isConnected;
  UsersProvider({
    this.users,
    this.failure,
    this.isConnected,
  });
  void eitherFailureOrUsers() async {
    UserRepositoryImpl repository = UserRepositoryImpl(
      remoteDataSource: UsersRemoteDataSourceImpl(dio: Dio()),
      localDataSource: UsersLocalDataSourceImpl(
          sharedPreferences: await SharedPreferences.getInstance()),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );
    final failureOrUsers = await repository.getUsers();
    failureOrUsers?.fold(
      (newFailure) {
        users = null;
        isConnected = null;
        failure = newFailure;
        notifyListeners();
      },
      (repositoryUsers) async {
        users = repositoryUsers;
        isConnected = await repository.networkInfo.isConnected;
        failure = null;
        notifyListeners();
      },
    );
  }
}
