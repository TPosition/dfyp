import 'package:bloc/bloc.dart';
import 'package:complaints_repository/complaint_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'complaint_state.dart';

class ComplaintCubit extends Cubit<ComplaintState> {
  ComplaintCubit(this._complaintRepository) : super(const ComplaintState());

  final FirebaseComplaintsRepository _complaintRepository;

  void titleChanged(String value) {
    emit(state.copyWith(
      title: value,
    ));
  }

  void commentChanged(String value) {
    emit(state.copyWith(
      comment: value,
    ));
  }

  Future<void> formSubmit(String uid) async {
    try {
      await _complaintRepository.addNewComplaint(Complaint(
        uid: uid,
        title: state.title,
        comment: state.comment,
      ));
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
