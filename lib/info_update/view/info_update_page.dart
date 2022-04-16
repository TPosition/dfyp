import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/info_update/cubit/info_update_cubit.dart';
import '/info_update/view/view.dart';
import 'package:users_repository/users_repository.dart';

class InfoUpdatePage extends StatelessWidget {
  const InfoUpdatePage({final Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute<void>(
        builder: (final _) => const InfoUpdatePage(),
      );

  static Page page() => const MaterialPage<void>(
        child: InfoUpdatePage(),
      );

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: BlocProvider<InfoUpdateCubit>(
            create: (final _) =>
                InfoUpdateCubit(context.read<FirebaseUsersRepository>()),
            child: const InfoUpdateForm(),
          ),
        ),
      );
}
