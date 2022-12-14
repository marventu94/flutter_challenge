import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';

abstract class UsersLocalDataSource {
  Future<void>? cacheUsers(List<UserModel>? usersToCache);
  Future<List<UserModel>>? getAllUsers();
}

const cachedUsers = 'CACHED_USERS';

class UsersLocalDataSourceImpl implements UsersLocalDataSource {
  final SharedPreferences sharedPreferences;

  UsersLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void>? cacheUsers(List<UserModel>? usersToCache) {
    if (usersToCache != null) {
      return sharedPreferences.setString(cachedUsers, jsonEncode(usersToCache));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<UserModel>>? getAllUsers() {
    final jsonString = sharedPreferences.getString(cachedUsers);
    if (jsonString != null) {
      Iterable ite = json.decode(jsonString);
      return Future.value(
          List<UserModel>.from(ite.map((model) => UserModel.fromJson(model))));
    } else {
      throw CacheException();
    }
  }
}
