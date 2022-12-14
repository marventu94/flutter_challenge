import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/post_model.dart';

const baseUrl = "https://jsonplaceholder.typicode.com";

abstract class PostsRemoteDataSource {
  Future<List<PostModel>>? getAllPosts();
  Future<Unit> addPost(PostModel postModel);
}

class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  final Dio dio;

  PostsRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<PostModel>>? getAllPosts() async {
    try {
      final response = await dio.get('$baseUrl/posts');
      return List<PostModel>.from(
          response.data.map((model) => PostModel.fromJson(model)));
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    try {
      final postJson =
          json.encode({"title": postModel.title, "body": postModel.body});
      await dio.post(
        '$baseUrl/posts',
        options: Options(headers: {"Content-Type": "application/json"}),
        data: postJson,
      );
      return Future.value(unit);
    } catch (e) {
      throw ServerException();
    }
  }
}
