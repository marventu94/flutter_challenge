import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/string/app_string.dart';
import '../../../../core/util/snackbar_message.dart';
import '../provider/post_add_provider.dart';
import '../widgets/form_add_post.dart';

class PostAddPage extends StatelessWidget {
  const PostAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? message = Provider.of<PostAddProvider>(context).message;
    if (message != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        SnakBarMessage().showSuccessSnackBar(
          message: message,
          context: context,
        );
        Provider.of<PostAddProvider>(context, listen: false).cleanMessage();
        Navigator.pop(context);
      });
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppString.postAdd),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.00),
          child: FormAddPost(),
        ),
      ),
    );
  }
}
