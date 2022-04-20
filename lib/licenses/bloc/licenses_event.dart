part of 'licenses_bloc.dart';

abstract class LicensesEvent extends Equatable {
  const LicensesEvent();

  @override
  List<Object> get props => [];
}

class LoadLicenses extends LicensesEvent {}

class AddLicense extends LicensesEvent {
  final License license;

  const AddLicense(this.license);

  @override
  List<Object> get props => [license];

  @override
  String toString() => 'AddLicense { license: $license }';
}

class UpdateLicense extends LicensesEvent {
  final License updatedLicense;

  const UpdateLicense(this.updatedLicense);

  @override
  List<Object> get props => [updatedLicense];

  @override
  String toString() => 'UpdateLicense { updatedLicense: $updatedLicense }';
}

class LicensesUpdated extends LicensesEvent {
  final List<License> licenses;

  const LicensesUpdated(this.licenses);

  @override
  List<Object> get props => [licenses];
}

// class DeleteLicense extends LicensesEvent {
//   final License license;

//   const DeleteLicense(this.license);

//   @override
//   List<Object> get props => [license];

//   @override
//   String toString() => 'DeleteLicense { license: $license }';
// }
