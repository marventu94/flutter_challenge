import 'package:flutter/material.dart';
import 'package:flutter_challenge/features/post/domain/entities/posts.dart';
import 'package:provider/provider.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/string/app_string.dart';
import '../../../../core/util/snackbar_message.dart';
import '../../../../core/widgets/list_card.dart';
import '../provider/posts_provider.dart';

class PostsView extends StatefulWidget {
  const PostsView({super.key});

  @override
  State<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> {
  @override
  void initState() {
    Provider.of<PostsProvider>(context, listen: false).eitherFailureOrPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    List<Post>? posts = Provider.of<PostsProvider>(context).posts;
    Failure? failure = Provider.of<PostsProvider>(context).failure;
    bool? isConnected = Provider.of<PostsProvider>(context).isConnected;

    if (isConnected != null && !isConnected) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        SnakBarMessage().showWarningSnackBar(
          message: AppString.noConnection,
          context: context,
        );
      });
    }

    if (posts != null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scrollbar(
          child: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ListCard(
                  title: posts[index].title,
                  subtitle: posts[index].body,
                ),
              );
            },
          ),
        ),
      );
    } else if (failure != null) {
      return Center(child: Text(failure.errorMessage!));
    } else {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: theme.colorScheme.background,
          color: theme.colorScheme.primary,
        ),
      );
    }
  }
}
