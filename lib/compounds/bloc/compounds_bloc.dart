import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:compounds_repository/compounds_repository.dart';

part 'compounds_event.dart';
part 'compounds_state.dart';

class CompoundsBloc extends Bloc<CompoundsEvent, CompoundsState> {
  CompoundsBloc({
    required final CompoundsRepository compoundsRepository,
  })  : _compoundsRepository = compoundsRepository,
        super(CompoundsLoading()) {
    on<LoadCompounds>(_onLoadCompounds);
    on<AddCompound>(_onAddCompound);
    on<CompoundsUpdated>(_onCompoundsUpdated);
    on<UpdateCompound>(_onUpdateCompound);
  }

  final CompoundsRepository _compoundsRepository;

  Future<void> _onLoadCompounds(
      final LoadCompounds event, final Emitter<CompoundsState> emit) {
    return emit.onEach<List<Compound>>(
      _compoundsRepository.compounds(),
      onData: (final compounds) => add(CompoundsUpdated(compounds)),
    );
  }

  void _onAddCompound(
      final AddCompound event, final Emitter<CompoundsState> emit) {
    _compoundsRepository.addNewCompound(event.compound);
  }

  void _onCompoundsUpdated(
      final CompoundsUpdated event, final Emitter<CompoundsState> emit) {
    emit(CompoundsLoaded(event.compounds));
  }

  void _onUpdateCompound(
      final UpdateCompound event, final Emitter<CompoundsState> emit) {
    _compoundsRepository.updateCompound(event.updatedCompound);
  }
}
