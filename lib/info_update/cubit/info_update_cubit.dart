import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:users_repository/users_repository.dart';

part 'info_update_state.dart';

class InfoUpdateCubit extends Cubit<InfoUpdateState> {
  InfoUpdateCubit(this._usersRepository) : super(const InfoUpdateState());

  final FirebaseUsersRepository _usersRepository;

  void displayNameChanged(final String value) {
    final displayName = StringInput.dirty(value);
    emit(
      state.copyWith(
        displayName: displayName,
        mobile: state.mobile,
        status: Formz.validate([
          displayName,
          state.mobile,
        ]),
      ),
    );
  }

  void mobileChanged(final String value) {
    final mobile = StringInput.dirty(value);
    emit(
      state.copyWith(
        displayName: state.displayName,
        mobile: mobile,
        status: Formz.validate([
          state.displayName,
          mobile,
        ]),
      ),
    );
  }

  Future<void> infoUpdateFormSubmitted(
    final String uid,
    final String email,
  ) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _usersRepository.updateUser(
        User(
            uid: uid,
            balance: 0,
            displayName: state.displayName.value,
            email: email,
            mobile: state.mobile.value,
            photoURL: 'https://picsum.photos/seed/${uid}/120/'),
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
