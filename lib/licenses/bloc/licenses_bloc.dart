import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:licenses_repository/licenses_repository.dart';

part 'licenses_event.dart';
part 'licenses_state.dart';

class LicensesBloc extends Bloc<LicensesEvent, LicensesState> {
  LicensesBloc({
    required final LicensesRepository licensesRepository,
  })  : _licensesRepository = licensesRepository,
        super(LicensesLoading()) {
    on<LoadLicenses>(_onLoadLicenses);
    on<AddLicense>(_onAddLicense);
    on<LicensesUpdated>(_onLicensesUpdated);
    on<UpdateLicense>(_onUpdateLicense);
  }

  final LicensesRepository _licensesRepository;

  Future<void> _onLoadLicenses(
          final LoadLicenses event, final Emitter<LicensesState> emit) =>
      emit.onEach<List<License>>(
        _licensesRepository.licenses(),
        onData: (final licenses) => add(LicensesUpdated(licenses)),
      );

  void _onAddLicense(
      final AddLicense event, final Emitter<LicensesState> emit) {
    _licensesRepository.addNewLicense(event.license);
  }

  void _onLicensesUpdated(
      final LicensesUpdated event, final Emitter<LicensesState> emit) {
    emit(LicensesLoaded(event.licenses));
  }

  void _onUpdateLicense(
      final UpdateLicense event, final Emitter<LicensesState> emit) {
    _licensesRepository.updateLicense(event.updatedLicense);
  }
}
