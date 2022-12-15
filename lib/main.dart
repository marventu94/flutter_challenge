import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/home/display/pages/log_in_page.dart';
import 'features/home/display/provider/selected_page_provider.dart';
import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SelectedPageProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Challenge',
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: const Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const LogInPage();
  }
}
