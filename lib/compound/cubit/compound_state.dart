part of 'compound_cubit.dart';

class CompoundState extends Equatable {
  const CompoundState({
    final this.licensesList = const [],
    final this.filteredLicensesList = const [],
  });

  final List<License> licensesList;
  final List<License?> filteredLicensesList;

  @override
  List<Object> get props => [licensesList, filteredLicensesList];

  CompoundState copyWith({
    final List<License>? licensesList,
    final List<License?>? filteredLicensesList,
  }) =>
      CompoundState(
        licensesList: licensesList ?? this.licensesList,
        filteredLicensesList: filteredLicensesList ?? this.filteredLicensesList,
      );
}
