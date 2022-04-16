part of 'transactions_bloc.dart';

abstract class TransactionsEvent extends Equatable {
  const TransactionsEvent();

  @override
  List<Object> get props => [];
}

class LoadTransactions extends TransactionsEvent {}

class AddTransaction extends TransactionsEvent {
  final Transaction transaction;

  const AddTransaction(this.transaction);

  @override
  List<Object> get props => [transaction];

  @override
  String toString() => 'AddTransaction { transaction: $transaction }';
}

class UpdateTransaction extends TransactionsEvent {
  final Transaction updatedTransaction;

  const UpdateTransaction(this.updatedTransaction);

  @override
  List<Object> get props => [updatedTransaction];

  @override
  String toString() =>
      'UpdateTransaction { updatedTransaction: $updatedTransaction }';
}

class TransactionsUpdated extends TransactionsEvent {
  final List<Transaction> transactions;

  const TransactionsUpdated(this.transactions);

  @override
  List<Object> get props => [transactions];
}

// class DeleteTransaction extends TransactionsEvent {
//   final Transaction transaction;

//   const DeleteTransaction(this.transaction);

//   @override
//   List<Object> get props => [transaction];

//   @override
//   String toString() => 'DeleteTransaction { transaction: $transaction }';
// }
