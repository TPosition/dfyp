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

enum CarCategory { car, motor }

class ApplicationForm extends StatelessWidget {
  const ApplicationForm({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final user =
        context.select((final CurrentUserBloc bloc) => bloc.state.user);

    final selectCategory = context.select(
      (final ApplicationCubit bloc) => bloc.state.isCar,
    );
    final selectType = context.select(
      (final ApplicationCubit bloc) => bloc.state.type,
    );

    final typeList = ['LDL', 'PDL', 'CDL', 'VL'];
    final typeListName = [
      'Learner Driving Licence (LDL)',
      'Probationary Driving Licence (PDL)',
      'Competent Driving Licence (CDL)',
      'Vocational Licence'
    ];
    final lclassList = ['A', 'A1', 'B', 'B1', 'D'];
    final periodList = [1, 2, 3, 4, 5];

    final carClassList = ['D', 'DA'];
    final carClassListName = [
      'Motor Car unladen weight not exceeding 3500 kg',
      'Motor Car Without Clutch Pedal unladen weight not exceeding 3500 kg'
    ];
    final motorClassList = ['B', 'B1', 'B2'];
    final motorClassListName = [
      'Motorcycle exceeding 500 cc',
      'Motorcycle not exceeding 500 cc',
      'Motorcycle not exceeding 250 cc'
    ];

    final ldlPeriodList = [3, 6, 12, 24];
    final pdlPeriodList = [24];
    final cdlPeriodList = [12, 24, 36, 48, 60];

    final vlTypeList = ['GDL', 'PSV'];
    final vlClassList = ['B', 'B2', 'E', 'D'];
    final vlPeriodList = [12];

    final departmentList = ['APAD', 'LPKP Sabah', 'LPKP Sarawak'];

    final sizeWidth = MediaQuery.of(context).size.width * 3 / 4;
    CarCategory _isCar = CarCategory.car;

    return BlocListener<ApplicationCubit, ApplicationState>(
      listener: (final context, final state) {
        if (state.status.isSubmissionSuccess) {
          try {
            context.read<LicensesBloc>().add(
                  AddLicense(
                    License(
                      uid: user.uid,
                      type: state.type,
                      lclass: state.lclass,
                      period: state.period,
                      department: state.department,
                      expiry:
                          DateTime.now().add(Duration(days: state.period * 30)),
                      status: "pending",
                    ),
                  ),
                );
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
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(Icons.arrow_back),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              const Text(
                                'Application',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
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
                                      'Category',
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
                                  child: const RadioOption(),
                                ),
                              ],
                            ),
                          ),
                          if (selectCategory)
                            _lclassWidget(
                              sizeWidth,
                              context,
                              carClassList,
                              carClassListName,
                            )
                          else
                            _lclassWidget(
                              sizeWidth,
                              context,
                              motorClassList,
                              motorClassListName,
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
                                            child: Text(
                                              typeListName[
                                                  typeList.indexOf(item)],
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (final String? value) {
                                      if (value == 'LDL') {
                                        context
                                            .read<ApplicationCubit>()
                                            .periodChanged(3);
                                      }
                                      if (value == 'LDL') {
                                        context
                                            .read<ApplicationCubit>()
                                            .periodChanged(3);
                                      }
                                      if (value == 'PDL') {
                                        context
                                            .read<ApplicationCubit>()
                                            .periodChanged(24);
                                      }
                                      if (value == 'CDL') {
                                        context
                                            .read<ApplicationCubit>()
                                            .periodChanged(12);
                                      }
                                      if (value == 'VL') {
                                        context
                                            .read<ApplicationCubit>()
                                            .periodChanged(12);
                                      }

                                      context
                                          .read<ApplicationCubit>()
                                          .typeChanged(value!);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (selectType == 'LDL')
                            _periodWidget(sizeWidth, context, ldlPeriodList),
                          if (selectType == 'PDL')
                            _periodWidget(sizeWidth, context, pdlPeriodList),
                          if (selectType == 'CDL')
                            _periodWidget(sizeWidth, context, cdlPeriodList),
                          if (selectType == 'VL')
                            _periodWidget(sizeWidth, context, vlPeriodList),
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
                                    user.mobile,
                                  );
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

  Column _periodWidget(final double sizeWidth, final BuildContext context,
          final List<int> periodList) =>
      Column(
        children: [
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
                      'Period (month)',
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
                      (final ApplicationCubit bloc) => bloc.state.period,
                    ),
                    items: periodList
                        .map<DropdownMenuItem<int>>(
                          (final int item) => DropdownMenuItem<int>(
                            value: item,
                            child: Text(item.toString()),
                          ),
                        )
                        .toList(),
                    onChanged: (final int? value) {
                      context.read<ApplicationCubit>().periodChanged(value!);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  Column _lclassWidget(final double sizeWidth, final BuildContext context,
          final List<String> lclassList, final List<String> lclassListName) =>
      Column(
        children: [
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
                    itemHeight: 80,
                    underline: const SizedBox(),
                    isExpanded: true,
                    value: context.select(
                      (final ApplicationCubit bloc) => bloc.state.lclass,
                    ),
                    items: lclassList
                        .map<DropdownMenuItem<String>>(
                          (final String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              '$item - ${lclassListName[lclassList.indexOf(item)]}',
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (final String? value) {
                      context.read<ApplicationCubit>().lclassChanged(value!);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}

class RadioOption extends StatefulWidget {
  const RadioOption({final Key? key}) : super(key: key);

  @override
  State<RadioOption> createState() => _RadioOption();
}

class _RadioOption extends State<RadioOption> {
  CarCategory? _isCar = CarCategory.car;

  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<ApplicationCubit, ApplicationState>(
        buildWhen: (final previous, final current) =>
            previous.isCar != current.isCar,
        builder: (final context, final state) => Column(
          children: <Widget>[
            ListTile(
              title: const Text('Car'),
              leading: Radio<CarCategory>(
                value: CarCategory.car,
                groupValue: _isCar,
                onChanged: (final CarCategory? value) {
                  context.read<ApplicationCubit>().lclassChanged('D');
                  context.read<ApplicationCubit>().isCarChanged(true);
                  setState(() {
                    _isCar = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Motor'),
              leading: Radio<CarCategory>(
                value: CarCategory.motor,
                groupValue: _isCar,
                onChanged: (final CarCategory? value) {
                  context.read<ApplicationCubit>().lclassChanged('B');
                  context.read<ApplicationCubit>().isCarChanged(false);
                  setState(() {
                    _isCar = value;
                  });
                },
              ),
            ),
          ],
        ),
      );
}
