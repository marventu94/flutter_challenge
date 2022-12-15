import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../core/string/app_string.dart';
import '../../../../core/util/snackbar_message.dart';

class PostAddPage extends StatelessWidget {
  const PostAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppString.postAdd),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.00),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                onChanged: (value) {
                  if (value.isNotEmpty) {}
                },
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  isDense: true,
                  border: const OutlineInputBorder(),
                  labelText: AppString.postTitle,
                ),
              ),
              const SizedBox(height: 25),
              TextFormField(
                onChanged: (value) {
                  if (value.isNotEmpty) {}
                },
                maxLines: 8,
                decoration: InputDecoration(
                  isDense: true,
                  border: const OutlineInputBorder(),
                  labelText: AppString.postBody,
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Agregar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
