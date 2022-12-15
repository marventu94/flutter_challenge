import 'package:flutter/material.dart';
import 'package:flutter_challenge/core/string/app_string.dart';
import 'package:provider/provider.dart';

import '../provider/selected_page_provider.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    int selectedPage = Provider.of<SelectedPageProvider>(context).selectedPage;
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.supervisor_account),
          label: AppString.users,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.menu),
          label: AppString.pots,
        ),
      ],
      currentIndex: selectedPage,
      selectedItemColor: theme.colorScheme.primary,
      onTap: (int index) {
        Provider.of<SelectedPageProvider>(context, listen: false)
            .changePage(index);
      },
    );
  }
}
