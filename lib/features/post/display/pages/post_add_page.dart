import 'package:flutter/material.dart';
import 'package:flutter_challenge/core/errors/failures.dart';
import 'package:flutter_challenge/features/post/display/provider/posts_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/string/app_string.dart';
import '../../../../core/util/snackbar_message.dart';
import '../provider/post_add_provider.dart';
import '../widgets/form_add_post.dart';

class PostAddPage extends StatefulWidget {
  const PostAddPage({super.key});

  @override
  State<PostAddPage> createState() => _PostAddPageState();
}

class _PostAddPageState extends State<PostAddPage> {
  UniqueKey formKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    String? message = Provider.of<PostAddProvider>(context).message;
    Failure? failure = Provider.of<PostAddProvider>(context).failure;
    bool? isConnected = Provider.of<PostsProvider>(context).isConnected;

    if (message != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        SnakBarMessage().showSuccessSnackBar(
          message: message,
          context: context,
        );
        Provider.of<PostAddProvider>(context, listen: false).cleanMessage();
        setState(() {
          formKey = UniqueKey();
        });
      });
    }

    if (failure != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        SnakBarMessage().showErrorSnackBar(
          message: failure.errorMessage!,
          context: context,
        );
        Provider.of<PostAddProvider>(context, listen: false).cleanFailure();
      });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppString.postAdd),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.00),
          child: FormAddPost(
            key: formKey,
            isConnected: isConnected ?? false,
          ),
        ),
      ),
    );
  }
}
