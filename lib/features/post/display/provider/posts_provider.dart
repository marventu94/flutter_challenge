import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/connection/network_info.dart';
import '../../../../core/errors/failures.dart';
import '../../data/datasources/posts_local_data_source.dart';
import '../../data/datasources/posts_remote_data_source.dart';
import '../../data/repositories/post_repository_impl.dart';
import '../../domain/entities/posts.dart';

class PostsProvider extends ChangeNotifier {
  List<Post>? posts;
  Failure? failure;
  bool? isConnected;

  PostsProvider({
    this.posts,
    this.failure,
    this.isConnected,
  });

  void eitherFailureOrPosts() async {
    PostRepositoryImpl repository = PostRepositoryImpl(
      remoteDataSource: PostsRemoteDataSourceImpl(dio: Dio()),
      localDataSource: PostsLocalDataSourceImpl(
          sharedPreferences: await SharedPreferences.getInstance()),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );
    final failureOrPosts = await repository.getPosts();
    failureOrPosts?.fold(
      (newFailure) {
        posts = null;
        isConnected = null;
        failure = newFailure;
        notifyListeners();
      },
      (repositoryPosts) async {
        posts = repositoryPosts;
        isConnected = await repository.networkInfo.isConnected;
        failure = null;
        notifyListeners();
      },
    );
  }
}
