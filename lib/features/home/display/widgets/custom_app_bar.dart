import 'package:flutter/material.dart';

import '../pages/log_in_page.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: const Text('Flutter Challenge'),
      actions: [
        IconButton(
          onPressed: () async {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const LogInPage(),
              ),
            );
          },
          icon: const Icon(
            Icons.logout,
            color: Colors.orangeAccent,
          ),
        ),
      ],
    );
  }
}
