import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/posts.dart';
import '../repositories/post_repository.dart';

class CreatePosts {
  final PostRepository repository;
  CreatePosts(this.repository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.addPost(post);
  }
}
