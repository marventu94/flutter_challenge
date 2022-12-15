import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/string/app_string.dart';
import '../../../../core/util/snackbar_message.dart';
import '../../domain/entities/posts.dart';
import '../provider/post_add_provider.dart';

class FormAddPost extends StatefulWidget {
  const FormAddPost({super.key});

  @override
  State<FormAddPost> createState() => _FormAddPostState();
}

class _FormAddPostState extends State<FormAddPost> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  bool clicked = false;

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: titleController,
          decoration: InputDecoration(
            isDense: true,
            border: const OutlineInputBorder(),
            labelText: AppString.postTitle,
          ),
        ),
        const SizedBox(height: 25),
        TextFormField(
          controller: bodyController,
          maxLines: 8,
          decoration: InputDecoration(
            isDense: true,
            border: const OutlineInputBorder(),
            labelText: AppString.postBody,
          ),
        ),
        const SizedBox(height: 25),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: clicked
                ? themeData.colorScheme.primary.withOpacity(0.7)
                : themeData.colorScheme.primary,
          ),
          onPressed: () {
            if (titleController.text.isEmpty || bodyController.text.isEmpty) {
              SnakBarMessage().showErrorSnackBar(
                message: AppString.emptyFields,
                context: context,
              );
            }
            if (!clicked) {
              setState(() {
                clicked = true;
              });
              Provider.of<PostAddProvider>(context, listen: false)
                  .eitherFailureOrDoneMessage(
                Post(
                  title: titleController.text,
                  body: bodyController.text,
                  id: null,
                ),
              );
            }
          },
          child: const Text('Agregar'),
        ),
      ],
    );
  }

  cleanUp() {
    FocusScope.of(context).unfocus();
    titleController.text = '';
    bodyController.text = '';
    setState(() {
      clicked = false;
    });
  }
}
