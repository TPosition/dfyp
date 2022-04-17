import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:users_repository/users_repository.dart';

part 'info_update_state.dart';

class InfoUpdateCubit extends Cubit<InfoUpdateState> {
  InfoUpdateCubit(this._usersRepository) : super(const InfoUpdateState());

  final FirebaseUsersRepository _usersRepository;
  final _storage = FirebaseStorageRepository();

  void displayNameChanged(final String value) {
    final displayName = StringInput.dirty(value);
    emit(
      state.copyWith(
        displayName: displayName,
        mobile: state.mobile,
        address: state.address,
        status: Formz.validate([
          displayName,
          state.mobile,
          state.address,
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
        address: state.address,
        status: Formz.validate([
          state.displayName,
          mobile,
          state.address,
        ]),
      ),
    );
  }

  void addressChanged(final String value) {
    final address = StringInput.dirty(value);
    emit(
      state.copyWith(
        displayName: state.displayName,
        mobile: state.mobile,
        address: address,
        status: Formz.validate([
          state.displayName,
          state.mobile,
          address,
        ]),
      ),
    );
  }

  void imageChanged(final bool isChanged) {
    emit(
      state.copyWith(
        displayName: state.displayName,
        mobile: state.mobile,
        status: Formz.validate([
          state.displayName,
          state.mobile,
        ]),
        hasImage: isChanged,
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
      final String photoURL = await _storage.getImageURL('$uid/avatar.png');

      await _usersRepository.updateUser(
        User(
          uid: uid,
          balance: 0,
          displayName: state.displayName.value,
          email: email,
          mobile: state.mobile.value,
          photoURL: photoURL,
          address: state.address.value,
        ),
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
