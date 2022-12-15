import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/post_model.dart';

abstract class PostsLocalDataSource {
  Future<void>? cachePosts(List<PostModel>? postsToCache);
  Future<List<PostModel>>? getPosts();
}

const cachedPosts = 'CACHED_POSTS';

class PostsLocalDataSourceImpl implements PostsLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void>? cachePosts(List<PostModel>? postsToCache) {
    if (postsToCache != null) {
      return sharedPreferences.setString(cachedPosts, jsonEncode(postsToCache));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<PostModel>>? getPosts() {
    final jsonString = sharedPreferences.getString(cachedPosts);
    if (jsonString != null) {
      Iterable ite = json.decode(jsonString);
      return Future.value(
          List<PostModel>.from(ite.map((model) => PostModel.fromJson(model))));
    } else {
      throw CacheException();
    }
  }
}
