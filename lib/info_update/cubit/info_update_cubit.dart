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
    emit(
      state.copyWith(
        displayName: value,
      ),
    );
  }

  void mobileChanged(final String value) {
    emit(
      state.copyWith(
        mobile: value,
      ),
    );
  }

  void addressChanged(final String value) {
    emit(
      state.copyWith(
        address: value,
      ),
    );
  }

  void imageChanged(final bool isChanged) {
    emit(
      state.copyWith(
        hasImage: isChanged,
      ),
    );
  }

  void genderChanged(final String value) {
    emit(state.copyWith(
      gender: value,
    ));
  }

  void fnameChanged(final String value) {
    emit(state.copyWith(
      fname: value,
    ));
  }

  void lnameChanged(final String value) {
    emit(state.copyWith(
      lname: value,
    ));
  }

  void nationalityChanged(final String value) {
    emit(state.copyWith(
      nationality: value,
    ));
  }

  void passportChanged(final String value) {
    emit(state.copyWith(
      passport: value,
    ));
  }

  void countryChanged(final String value) {
    emit(state.copyWith(
      country: value,
    ));
  }

  void postCodeChanged(final String value) {
    emit(state.copyWith(
      postCode: value,
    ));
  }

  void cityChanged(final String value) {
    emit(state.copyWith(
      city: value,
    ));
  }

  void provinceChanged(final String value) {
    emit(state.copyWith(
      province: value,
    ));
  }

  void maritalChanged(final String value) {
    emit(state.copyWith(
      marital: value,
    ));
  }

  Future<void> infoUpdateFormSubmitted(
    final String uid,
    final String email,
  ) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final String photoURL = await _storage.getImageURL('$uid/avatar.png');

      await _usersRepository.updateUser(
        User(
          uid: uid,
          balance: 0,
          displayName: state.displayName,
          email: email,
          mobile: state.mobile,
          photoURL: photoURL,
          address: state.address,
          gender: state.gender,
          fname: state.fname,
          lname: state.lname,
          nationality: state.nationality,
          passport: state.passport,
          country: state.country,
          postCode: state.postCode,
          city: state.city,
          province: state.province,
          marital: state.marital,
        ),
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
