import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:transactions_repository/transactions_repository.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsBloc({
    required final TransactionsRepository transactionsRepository,
  })  : _transactionsRepository = transactionsRepository,
        super(TransactionsLoading()) {
    on<LoadTransactions>(_onLoadTransactions);
    on<AddTransaction>(_onAddTransaction);
    on<TransactionsUpdated>(_onTransactionsUpdated);
    on<UpdateTransaction>(_onUpdateTransaction);
  }

  final TransactionsRepository _transactionsRepository;

  Future<void> _onLoadTransactions(final LoadTransactions event,
          final Emitter<TransactionsState> emit) =>
      emit.onEach<List<Transaction>>(
        _transactionsRepository.transactions(),
        onData: (final transactions) => add(TransactionsUpdated(transactions)),
      );

  void _onAddTransaction(
      final AddTransaction event, final Emitter<TransactionsState> emit) {
    _transactionsRepository.addNewTransaction(event.transaction);
  }

  void _onTransactionsUpdated(
      final TransactionsUpdated event, final Emitter<TransactionsState> emit) {
    emit(TransactionsLoaded(event.transactions));
  }

  void _onUpdateTransaction(
      final UpdateTransaction event, final Emitter<TransactionsState> emit) {
    _transactionsRepository.updateTransaction(event.updatedTransaction);
  }
}
