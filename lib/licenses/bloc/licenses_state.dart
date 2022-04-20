part of 'licenses_bloc.dart';

abstract class LicensesState extends Equatable {
  const LicensesState();

  @override
  List<Object> get props => [];
}

class LicensesLoading extends LicensesState {}

class LicensesLoaded extends LicensesState {
  final List<License> licenses;

  const LicensesLoaded([this.licenses = const []]);

  @override
  List<Object> get props => [licenses];

  @override
  String toString() => 'LicensesLoaded { licenses: $licenses }';
}

class LicensesInitial extends LicensesState {}
