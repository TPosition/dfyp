part of 'transactions_bloc.dart';

abstract class TransactionsState extends Equatable {
  const TransactionsState();

  @override
  List<Object> get props => [];
}

class TransactionsLoading extends TransactionsState {}

class TransactionsLoaded extends TransactionsState {
  final List<Transaction> transactions;

  const TransactionsLoaded([this.transactions = const []]);

  @override
  List<Object> get props => [transactions];

  @override
  String toString() => 'TransactionsLoaded { transactions: $transactions }';
}

class TransactionsInitial extends TransactionsState {}
