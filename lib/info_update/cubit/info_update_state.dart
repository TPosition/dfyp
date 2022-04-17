part of 'info_update_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

class InfoUpdateState extends Equatable {
  const InfoUpdateState({
    final this.displayName = const StringInput.pure(),
    final this.mobile = const StringInput.pure(),
    final this.status = FormzStatus.pure,
    final this.hasImage = false,
    final this.address = const StringInput.pure(),
  });

  final StringInput displayName;
  final StringInput mobile;
  final FormzStatus status;
  final bool hasImage;
  final StringInput address;

  @override
  List<Object> get props => [displayName, mobile, status, hasImage, address];

  InfoUpdateState copyWith({
    final StringInput? displayName,
    final StringInput? mobile,
    final FormzStatus? status,
    final bool? hasImage,
    final StringInput? address,
  }) =>
      InfoUpdateState(
        displayName: displayName ?? this.displayName,
        mobile: mobile ?? this.mobile,
        status: status ?? this.status,
        hasImage: hasImage ?? this.hasImage,
        address: address ?? this.address,
      );
}
