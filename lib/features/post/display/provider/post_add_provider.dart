import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_challenge/core/string/app_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/connection/network_info.dart';
import '../../../../core/errors/failures.dart';
import '../../data/datasources/posts_local_data_source.dart';
import '../../data/datasources/posts_remote_data_source.dart';
import '../../data/repositories/post_repository_impl.dart';
import '../../domain/entities/posts.dart';

class PostAddProvider extends ChangeNotifier {
  Failure? failure;
  String? message;

  PostAddProvider({
    this.message,
    this.failure,
  });

  void eitherFailureOrDoneMessage(Post post) async {
    PostRepositoryImpl repository = PostRepositoryImpl(
      remoteDataSource: PostsRemoteDataSourceImpl(dio: Dio()),
      localDataSource: PostsLocalDataSourceImpl(
          sharedPreferences: await SharedPreferences.getInstance()),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );
    final failureOrActivity = await repository.addPost(post);
    failureOrActivity.fold(
      (newFailure) {
        message = null;
        failure = newFailure;
        notifyListeners();
      },
      (_) {
        message = AppString.postSavedSuccessfully;
        failure = null;
        notifyListeners();
      },
    );
  }

  void cleanMessage() {
    message = null;
  }
}
