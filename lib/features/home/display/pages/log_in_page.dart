import 'package:flutter/material.dart';
import 'package:flutter_challenge/core/string/app_string.dart';
import 'package:flutter_challenge/features/home/data/models/basic_user_model.dart';
import 'package:flutter_challenge/features/home/display/pages/home_page.dart';

import '../../../../core/util/snackbar_message.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  BasicUserModel userLogIn = BasicUserModel.empty();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Container(
        color: theme.colorScheme.primary,
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SizedBox(
              width: 300,
              height: 400,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Flutter Chanllenge',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 50),
                    TextFormField(
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          userLogIn.username = value;
                        }
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        border: const OutlineInputBorder(),
                        labelText: AppString.user,
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          userLogIn.password = value;
                        }
                      },
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        isDense: true,
                        border: const OutlineInputBorder(),
                        labelText: AppString.password,
                      ),
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () {
                        if (userLogIn.username == "challenge@fudo" &&
                            userLogIn.password == "password") {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        } else {
                          SnakBarMessage().showErrorSnackBar(
                            message: AppString.incorrectCredentials,
                            context: context,
                          );
                        }
                      },
                      child: const Text('Entrar'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
