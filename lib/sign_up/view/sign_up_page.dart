import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/sign_up/sign_up.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({final Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute<void>(builder: (final _) => const SignUpPage());

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: BlocProvider<SignUpCubit>(
            create: (final _) =>
                SignUpCubit(context.read<AuthenticationRepository>()),
            child: const SignUpForm(),
          ),
        ),
      );
}
