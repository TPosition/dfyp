import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ispkp/info_update_company/cubit/info_update_company_cubit.dart';
import 'package:ispkp/info_update_company/view/view.dart';
import '/info_update/cubit/info_update_cubit.dart';
import '/info_update/view/view.dart';
import 'package:users_repository/users_repository.dart';

class InfoUpdateCompanyPage extends StatelessWidget {
  const InfoUpdateCompanyPage({final Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute<void>(
        builder: (final _) => const InfoUpdateCompanyPage(),
      );

  static Page page() => const MaterialPage<void>(
        child: InfoUpdateCompanyPage(),
      );

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: BlocProvider<InfoUpdateCompanyCubit>(
            create: (final _) =>
                InfoUpdateCompanyCubit(context.read<FirebaseUsersRepository>()),
            child: const InfoUpdateCompanyForm(),
          ),
        ),
      );
}
