import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ispkp/application/cubit/application_cubit.dart';
import 'package:ispkp/application/view/view.dart';
import 'package:licenses_repository/licenses_repository.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ApplicationPage extends StatelessWidget {
  const ApplicationPage({final Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute<void>(
        builder: (final _) => const ApplicationPage(),
      );

  static Page page() => const MaterialPage<void>(
        child: ApplicationPage(),
      );

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: BlocProvider<ApplicationCubit>(
            create: (final _) => ApplicationCubit(
                context.read<FirebaseLicensesRepository>(), Razorpay())
              ..init(),
            child: const ApplicationForm(),
          ),
        ),
      );
}
