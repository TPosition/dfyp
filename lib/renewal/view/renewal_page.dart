import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ispkp/licenses/bloc/licenses_bloc.dart';
import 'package:ispkp/renewal/cubit/renewal_cubit.dart';
import 'package:ispkp/renewal/view/view.dart';
import 'package:licenses_repository/licenses_repository.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RenewalPage extends StatelessWidget {
  const RenewalPage({final Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute<void>(
        builder: (final _) => const RenewalPage(),
      );

  static Page page() => const MaterialPage<void>(
        child: RenewalPage(),
      );

  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<LicensesBloc, LicensesState>(
        builder: (final context, final state) {
          if (state is LicensesLoaded) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8),
                child: BlocProvider<RenewalCubit>(
                  create: (final _) => RenewalCubit(
                    context.read<FirebaseLicensesRepository>(),
                    Razorpay(),
                    state.licenses,
                  )..init(),
                  child: const RenewalForm(),
                ),
              ),
            );
          }

          return const CircularProgressIndicator();
        },
      );
}
