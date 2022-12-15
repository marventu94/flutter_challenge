import 'package:flutter/material.dart';
import 'package:flutter_challenge/features/post/display/pages/post_add_page.dart';
import 'package:provider/provider.dart';

import '../../../post/display/pages/posts_view.dart';
import '../../../user/display/pages/users_view.dart';
import '../provider/selected_page_provider.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_bar.dart';

List<Widget> pages = const [PostsView(), UsersView()];

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  final int itemsNumber = 10;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    int selectedPage = Provider.of<SelectedPageProvider>(context).selectedPage;
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: const CustomAppBar(),
          body: pages[selectedPage],
          bottomNavigationBar: const CustomBottomBar(),
          floatingActionButton: selectedPage == 1
              ? FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PostAddPage(),
                      ),
                    );
                  },
                  backgroundColor: theme.colorScheme.primary,
                  child: const Icon(Icons.add),
                )
              : null,
        ),
      ),
    );
  }
}
