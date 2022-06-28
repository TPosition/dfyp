import 'package:complaints_repository/complaint_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ispkp/complaint/cubit/complaint_cubit.dart';
import 'package:ispkp/complaint/view/view.dart';
import 'package:complaints_repository/complaint_repository.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ComplaintPage extends StatelessWidget {
  const ComplaintPage({final Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute<void>(
        builder: (final _) => const ComplaintPage(),
      );

  static Page page() => const MaterialPage<void>(
        child: ComplaintPage(),
      );

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: BlocProvider<ComplaintCubit>(
            create: (final _) => ComplaintCubit(
              context.read<FirebaseComplaintsRepository>(),
            ),
            child: const ComplaintForm(),
          ),
        ),
      );
}
