import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:complaints_repository/complaint_repository.dart';

part 'complaints_event.dart';
part 'complaints_state.dart';

class ComplaintsBloc extends Bloc<ComplaintsEvent, ComplaintsState> {
  ComplaintsBloc({
    required final ComplaintsRepository complaintsRepository,
  })  : _complaintsRepository = complaintsRepository,
        super(ComplaintsLoading()) {
    on<LoadComplaints>(_onLoadComplaints);
    on<AddComplaint>(_onAddComplaint);
    on<ComplaintsUpdated>(_onComplaintsUpdated);
    on<UpdateComplaint>(_onUpdateComplaint);
  }

  final ComplaintsRepository _complaintsRepository;

  Future<void> _onLoadComplaints(
      final LoadComplaints event, final Emitter<ComplaintsState> emit) {
    print('yandex');
    return emit.onEach<List<Complaint>>(
      _complaintsRepository.complaints(),
      onData: (final complaints) => add(ComplaintsUpdated(complaints)),
    );
  }

  void _onAddComplaint(
      final AddComplaint event, final Emitter<ComplaintsState> emit) {
    _complaintsRepository.addNewComplaint(event.complaint);
  }

  void _onComplaintsUpdated(
      final ComplaintsUpdated event, final Emitter<ComplaintsState> emit) {
    emit(ComplaintsLoaded(event.complaints));
  }

  void _onUpdateComplaint(
      final UpdateComplaint event, final Emitter<ComplaintsState> emit) {
    _complaintsRepository.updateComplaint(event.updatedComplaint);
  }
}
