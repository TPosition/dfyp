import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ispkp/common/views/success_page.dart';
import 'package:ispkp/compounds/bloc/compounds_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '/current_user/bloc/current_user_bloc.dart';
import '/compound/cubit/compound_cubit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:formz/formz.dart';
import 'package:compounds_repository/compounds_repository.dart';

class CompoundPage extends StatelessWidget {
  const CompoundPage({final Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute<void>(
        builder: (final _) => const CompoundPage(),
      );

  @override
  Widget build(final BuildContext context) {
    const int _dropdownValue = 1;
    final user =
        context.select((final CurrentUserBloc bloc) => bloc.state.user);
    final DateTime selectedDate = DateTime.now();

    return BlocBuilder<CompoundsBloc, CompoundsState>(
      builder: (final context, final state) {
        if (state is CompoundsLoaded) {
          return BlocProvider(
              lazy: false,
              create: (final context) => CompoundCubit(
                  compounds: state.compounds, razorpay: Razorpay()),
              child: BlocProvider(
                lazy: false,
                create: (final context) => CompoundCubit(
                  compounds: state.compounds
                      .where((final element) => element.uid == user.uid)
                      .toList(),
                  razorpay: Razorpay(),
                )..init(),
                child: Scaffold(
                  backgroundColor: const Color(0xFFF4F4F4),
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, top: 50, bottom: 25),
                        child: Row(
                          children: <Widget>[
                            IconButton(
                                icon: const Icon(Icons.arrow_back),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }),
                            const Text(
                              'Compound',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<CompoundCubit, CompoundState>(
                        buildWhen: (final previous, final current) =>
                            previous.filteredCompoundsList !=
                            current.filteredCompoundsList,
                        builder: (final context, final state) =>
                            BlocListener<CompoundCubit, CompoundState>(
                          listener: (final context, final state) {
                            if (state.status.isSubmissionSuccess) {
                              try {
                                context.read<CompoundsBloc>().add(
                                      UpdateCompound(
                                        Compound(
                                          id: state.selectedCompound.id,
                                          uid: user.uid,
                                          agency: '',
                                          amount: state.selectedCompound.amount,
                                          reason: state.selectedCompound.reason,
                                          plate: state.selectedCompound.plate,
                                          isPaid: true,
                                        ),
                                      ),
                                    );
                              } on Exception {}
                              Navigator.of(context)
                                  .push<void>(SuccessPage.route());
                            } else if (state.status.isSubmissionFailure) {
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  const SnackBar(
                                      content: Text('Submit Failure')),
                                );
                            }
                          },
                          child: Expanded(
                            child: ListView.builder(
                                itemCount: state.filteredCompoundsList.isEmpty
                                    ? state.compoundsList.length
                                    : state.filteredCompoundsList.length,
                                itemBuilder: (final BuildContext context,
                                        final int index) =>
                                    _compoundWidget(state
                                            .filteredCompoundsList.isEmpty
                                        ? state.compoundsList[index]
                                        : state.filteredCompoundsList[index])),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        }
        return const SizedBox();
      },
    );
  }

  Widget _compoundWidget(final Compound? compound) =>
      Builder(builder: (final context) {
        final user =
            context.select((final CurrentUserBloc bloc) => bloc.state.user);
        if (compound != null && !compound.isPaid) {
          return SingleChildScrollView(
            child: Container(
              height: 80,
              margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: const SizedBox(),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  compound.plate,
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  compound.reason,
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                  textAlign: TextAlign.left,
                                ),
                              ]),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    textStyle: const TextStyle(
                                  fontSize: 12,
                                )),
                                onPressed: () async {
                                  context
                                      .read<CompoundCubit>()
                                      .selectedCompoundChanged(compound);

                                  await context
                                      .read<CompoundCubit>()
                                      .payCompound(
                                        user.uid,
                                        user.email,
                                        user.displayName,
                                        user.mobile,
                                        compound.amount,
                                      );
                                },
                                child: Text('Pay ${compound.amount}'),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return Container();
      });
}
