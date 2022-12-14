import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/posts.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>?>>? getPosts();
  Future<Either<Failure, Unit>> addPost(Post post);
}
