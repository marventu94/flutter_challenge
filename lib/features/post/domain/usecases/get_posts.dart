import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/posts.dart';
import '../repositories/post_repository.dart';

class GetPosts {
  final PostRepository repository;
  GetPosts(this.repository);

  Future<Either<Failure, List<Post>?>?> call() async {
    return repository.getPosts();
  }
}
