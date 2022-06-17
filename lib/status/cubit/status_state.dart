part of 'status_cubit.dart';

class StatusState extends Equatable {
  const StatusState({
    final this.licensesList = const [],
    final this.filteredLicensesList = const [],
  });

  final List<License> licensesList;
  final List<License?> filteredLicensesList;

  @override
  List<Object> get props => [licensesList, filteredLicensesList];

  StatusState copyWith({
    final List<License>? licensesList,
    final List<License?>? filteredLicensesList,
  }) =>
      StatusState(
        licensesList: licensesList ?? this.licensesList,
        filteredLicensesList: filteredLicensesList ?? this.filteredLicensesList,
      );
}
