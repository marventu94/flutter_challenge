import 'package:dartz/dartz.dart';

import '../../../../core/connection/network_info.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/string/failures.dart';
import '../../domain/entities/posts.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/posts_local_data_source.dart';
import '../datasources/posts_remote_data_source.dart';
import '../models/post_model.dart';

class PostRepositoryImpl implements PostRepository {
  final PostsRemoteDataSource remoteDataSource;
  final PostsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Post>?>>? getPosts() async {
    if (await networkInfo.isConnected!) {
      try {
        final remotePosts = await remoteDataSource.getPosts();
        localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(
          ServerFailure(errorMessage: FailuresMessage.offlineFailureMessage),
        );
      }
    } else {
      try {
        final localPosts = await localDataSource.getPosts();
        return Right(localPosts);
      } on CacheException {
        return Left(
          CacheFailure(errorMessage: FailuresMessage.emptyCacheFailureMessage),
        );
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    if (await networkInfo.isConnected!) {
      final PostModel postModel = PostModel(title: post.title, body: post.body);
      await remoteDataSource.addPost(postModel);
      return const Right(unit);
    } else {
      return Left(
        ServerFailure(errorMessage: FailuresMessage.offlineFailureMessage),
      );
    }
  }
}
