import 'package:flutter/material.dart';
import 'package:flutter_challenge/features/user/display/provider/users_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/string/app_string.dart';
import '../../../../core/util/snackbar_message.dart';
import '../../../../core/widgets/list_card.dart';
import '../../domain/entities/user.dart';

class UsersView extends StatefulWidget {
  const UsersView({super.key});

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  @override
  void initState() {
    Provider.of<UsersProvider>(context, listen: false).eitherFailureOrUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    List<User>? users = Provider.of<UsersProvider>(context).users;
    Failure? failure = Provider.of<UsersProvider>(context).failure;
    bool? isConnected = Provider.of<UsersProvider>(context).isConnected;

    if (isConnected != null && !isConnected) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        SnakBarMessage().showWarningSnackBar(
          message: AppString.noConnection,
          context: context,
        );
      });
    }

    if (users != null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scrollbar(
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ListCard(
                  title: users[index].email,
                  subtitle: users[index].name,
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
