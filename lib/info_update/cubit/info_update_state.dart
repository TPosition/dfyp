part of 'info_update_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

class InfoUpdateState extends Equatable {
  const InfoUpdateState({
    final this.displayName = const StringInput.pure(),
    final this.mobile = const StringInput.pure(),
    final this.status = FormzStatus.pure,
  });

  final StringInput displayName;
  final StringInput mobile;
  final FormzStatus status;

  @override
  List<Object> get props => [displayName, mobile, status];

  InfoUpdateState copyWith({
    final StringInput? displayName,
    final StringInput? mobile,
    final FormzStatus? status,
  }) =>
      InfoUpdateState(
        displayName: displayName ?? this.displayName,
        mobile: mobile ?? this.mobile,
        status: status ?? this.status,
      );
}
