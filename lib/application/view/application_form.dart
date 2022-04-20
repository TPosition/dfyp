import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ispkp/application/cubit/application_cubit.dart';
import 'package:ispkp/common/views/success_page.dart';
import 'package:ispkp/current_user/bloc/current_user_bloc.dart';
import 'package:ispkp/licenses/bloc/licenses_bloc.dart';
import 'package:ispkp/transactions/bloc/transactions_bloc.dart';
import 'package:ispkp/transactions/transaction_category_constant.dart';
import 'package:licenses_repository/licenses_repository.dart';
import 'package:transactions_repository/transactions_repository.dart';
import '/app/app.dart';
import '/common/widgets/avatar.dart';
import '/info_update/cubit/info_update_cubit.dart';
import 'package:formz/formz.dart';
import 'package:storage_repository/storage_repository.dart';

class ApplicationForm extends StatelessWidget {
  const ApplicationForm({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final user =
        context.select((final CurrentUserBloc bloc) => bloc.state.user);

    final typeList = ['LDL', 'PDL', 'CDL', 'VL'];
    final lclassList = ['A', 'A1', 'B', 'B1', 'D'];
    final periodList = [1, 2, 3, 4, 5];
    final departmentList = ['APAD', 'LPKP Sabah', 'LPKP Sarawak'];

    final sizeWidth = MediaQuery.of(context).size.width * 3 / 4;

    return BlocListener<ApplicationCubit, ApplicationState>(
      listener: (final context, final state) {
        if (state.status.isSubmissionSuccess) {
          try {
            context.read<LicensesBloc>().add(AddLicense(
                  License(
                    uid: user.uid,
                    type: state.type,
                    lclass: state.lclass,
                    period: state.period,
                    department: state.department,
                    expiry:
                        DateTime.now().add(Duration(days: state.period * 365)),
                    status: "pending",
                  ),
                ));
          } on Exception {}

          context.read<TransactionsBloc>().add(
                AddTransaction(
                  Transaction(
                    amount: state.amount.toDouble(),
                    category: ktopup,
                    receiverDisplayName: user.displayName,
                    receiverUID: user.uid,
                  ),
                ),
              );

          Navigator.of(context).push<void>(SuccessPage.route());
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Submit Failure')),
            );
        }
      },
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  'Application',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: const Color(0xffFFFFFF),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                              right: 25,
                              top: 25,
                            ),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[
                                    Text(
                                      'Type of license',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                              top: 2,
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: sizeWidth,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: DropdownButton(
                                    underline: const SizedBox(),
                                    isExpanded: true,
                                    value: context.select(
                                      (final ApplicationCubit bloc) =>
                                          bloc.state.type,
                                    ),
                                    items: typeList
                                        .map<DropdownMenuItem<String>>(
                                          (final String item) =>
                                              DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(item),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (final String? value) {
                                      context
                                          .read<ApplicationCubit>()
                                          .typeChanged(value!);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                              right: 25,
                              top: 25,
                            ),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[
                                    Text(
                                      'Class of license',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                              top: 2,
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: sizeWidth,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: DropdownButton(
                                    underline: const SizedBox(),
                                    isExpanded: true,
                                    value: context.select(
                                      (final ApplicationCubit bloc) =>
                                          bloc.state.lclass,
                                    ),
                                    items: lclassList
                                        .map<DropdownMenuItem<String>>(
                                          (final String item) =>
                                              DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(item),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (final String? value) {
                                      context
                                          .read<ApplicationCubit>()
                                          .lclassChanged(value!);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                              right: 25,
                              top: 25,
                            ),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[
                                    Text(
                                      'Period (year)',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                              top: 2,
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: sizeWidth,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: DropdownButton(
                                    underline: const SizedBox(),
                                    isExpanded: true,
                                    value: context.select(
                                      (final ApplicationCubit bloc) =>
                                          bloc.state.period,
                                    ),
                                    items: periodList
                                        .map<DropdownMenuItem<int>>(
                                          (final int item) =>
                                              DropdownMenuItem<int>(
                                            value: item,
                                            child: Text(item.toString()),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (final int? value) {
                                      context
                                          .read<ApplicationCubit>()
                                          .periodChanged(value!);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                              right: 25,
                              top: 25,
                            ),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[
                                    Text(
                                      'Department',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                              top: 2,
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: sizeWidth,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: DropdownButton(
                                    underline: const SizedBox(),
                                    isExpanded: true,
                                    value: context.select(
                                      (final ApplicationCubit bloc) =>
                                          bloc.state.department,
                                    ),
                                    items: departmentList
                                        .map<DropdownMenuItem<String>>(
                                      (final String item) {
                                        var _img = '';
                                        if (item == departmentList[0]) {
                                          _img = 'apad';
                                        }
                                        if (item == departmentList[1]) {
                                          _img = 'sabah';
                                        }
                                        if (item == departmentList[2]) {
                                          _img = 'sarawak';
                                        }
                                        return DropdownMenuItem<String>(
                                          value: item,
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                              bottom: 5,
                                            ),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  'assets/$_img.png',
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Text(item),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ).toList(),
                                    onChanged: (final String? value) {
                                      context
                                          .read<ApplicationCubit>()
                                          .departmentChanged(value!);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () async {
                              await context
                                  .read<ApplicationCubit>()
                                  .applicationFormSubmitted(
                                      user.uid,
                                      user.email,
                                      user.displayName,
                                      user.mobile);
                            },
                            color: Colors.yellowAccent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              "Pay ${context.select((final ApplicationCubit bloc) => bloc.state.amount)}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
