import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/login/login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({final Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: LoginPage());

  static Route route() =>
      MaterialPageRoute<void>(builder: (final _) => const LoginPage());

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: BlocProvider(
            create: (final _) =>
                LoginCubit(context.read<AuthenticationRepository>()),
            child: const LoginForm(),
          ),
        ),
      );
}
