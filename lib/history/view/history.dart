import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/current_user/bloc/current_user_bloc.dart';
import '/history/cubit/history_cubit.dart';
import '/transactions/bloc/transactions_bloc.dart';
import '/transactions/transaction_category_constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transactions_repository/transactions_repository.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    const int _dropdownValue = 1;
    final user =
        context.select((final CurrentUserBloc bloc) => bloc.state.user);
    final DateTime selectedDate = DateTime.now();

    Future _selectDate(final BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101),
      );
      if (picked != null && picked != selectedDate) {
        context.read<HistoryCubit>().datePicked(picked);
      }
    }

    return BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: (final context, final state) {
        if (state is TransactionsLoaded) {
          return BlocProvider(
            create: (final context) => HistoryCubit(
                transactions: state.transactions
                    .where((element) => element.receiverUID == user.uid)
                    .toList(),
                uid: user.uid)
              ..init(),
            child: Scaffold(
              backgroundColor: const Color(0xFFF4F4F4),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 50, bottom: 25),
                    child: Text(
                      'Transactions History',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w900, fontSize: 22),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Row(children: <Widget>[
                        Expanded(
                          child: Container(
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 5),
                                child: BlocBuilder<HistoryCubit, HistoryState>(
                                  builder: (final context, final state) =>
                                      DropdownButton(
                                    hint: const Text('Category'),
                                    icon: const Icon(Icons.arrow_downward),
                                    elevation: 16,
                                    value: _dropdownValue,
                                    items: [
                                      DropdownMenuItem(
                                        value: 1,
                                        child: Text(
                                          "All",
                                          style: GoogleFonts.roboto(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 2,
                                        child: Text(
                                          "Application",
                                          style: GoogleFonts.roboto(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                          value: 3,
                                          child: Text(
                                            "Renewal",
                                            style: GoogleFonts.roboto(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          )),
                                      DropdownMenuItem(
                                          value: 4,
                                          child: Text(
                                            "Compound",
                                            style: GoogleFonts.roboto(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          )),
                                      DropdownMenuItem(
                                        value: 5,
                                        child: Text(
                                          "Date",
                                          style: GoogleFonts.roboto(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                    onChanged: (final int? value) {
                                      if (value != null) {
                                        context
                                            .read<HistoryCubit>()
                                            .searchChanged(value);
                                      }

                                      if (value == 5) {
                                        _selectDate(context);
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  BlocBuilder<HistoryCubit, HistoryState>(
                    buildWhen: (final previous, final current) =>
                        previous.filteredTransactionsList !=
                        current.filteredTransactionsList,
                    builder: (final context, final state) => Expanded(
                      child: ListView.builder(
                          itemCount: state.filteredTransactionsList.isEmpty
                              ? state.transactionsList.length
                              : state.filteredTransactionsList.length,
                          itemBuilder: (final BuildContext context,
                                  final int index) =>
                              _historyWidget(
                                  state.filteredTransactionsList.isEmpty
                                      ? state.transactionsList[index]
                                      : state.filteredTransactionsList[index])),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _historyWidget(final Transaction? transaction) =>
      Builder(builder: (final context) {
        final user =
            context.select((final CurrentUserBloc bloc) => bloc.state.user);
        if (transaction != null) {
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
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Image.asset(
                          transaction.category == kapplication
                              ? 'assets/ico_pay_phone.png'
                              : transaction.category == krenewal
                                  ? 'assets/ico_receive_money.png'
                                  : 'assets/ico_send_money.png',
                          height: 30,
                          width: 30,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  transaction.category,
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
                              Text(
                                transaction.receiverUID == user.uid
                                    ? '  RM ${transaction.amount}'
                                    : ' - RM ${transaction.amount}',
                                style: GoogleFonts.roboto(
                                    color: transaction.receiverUID == user.uid
                                        ? Colors.green
                                        : Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      " ${transaction.timestamp.day}/${transaction.timestamp.month}/${transaction.timestamp.year} ${transaction.timestamp.hour}:${transaction.timestamp.minute}",
                                      textAlign: TextAlign.right,
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              )
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
