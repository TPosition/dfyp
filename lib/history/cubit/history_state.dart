part of 'history_cubit.dart';

class HistoryState extends Equatable {
  const HistoryState({
    final this.transactionsList = const [],
    final this.filteredTransactionsList = const [],
  });

  final List<Transaction> transactionsList;
  final List<Transaction?> filteredTransactionsList;

  @override
  List<Object> get props => [transactionsList, filteredTransactionsList];

  HistoryState copyWith({
    final List<Transaction>? transactionsList,
    final List<Transaction?>? filteredTransactionsList,
  }) =>
      HistoryState(
        transactionsList: transactionsList ?? this.transactionsList,
        filteredTransactionsList:
            filteredTransactionsList ?? this.filteredTransactionsList,
      );
}
