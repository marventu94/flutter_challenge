import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';

abstract class UsersRemoteDataSource {
  Future<List<UserModel>>? getAllUsers();
}

class UsersRemoteDataSourceImpl implements UsersRemoteDataSource {
  final Dio dio;

  UsersRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<UserModel>>? getAllUsers() async {
    try {
      final response =
          await dio.get('https://jsonplaceholder.typicode.com/users');
      return List<UserModel>.from(
          response.data.map((model) => UserModel.fromJson(model)));
    } catch (e) {
      throw ServerException();
    }
  }
}