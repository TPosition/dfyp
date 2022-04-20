part of 'renewal_cubit.dart';

class RenewalState extends Equatable {
  const RenewalState({
    required final this.lid,
    final this.period = 1,
    final this.status = FormzStatus.pure,
    final this.licensesList = const [],
  }) : amount = period * 60;

  final License lid;
  final FormzStatus status;
  final int amount;
  final int period;
  final List<License> licensesList;

  @override
  List<Object> get props => [
        lid,
        status,
        amount,
        period,
        licensesList,
      ];

  RenewalState copyWith({
    final License? lid,
    final int? period,
    final FormzStatus? status,
    final List<License>? licensesList,
  }) =>
      RenewalState(
        lid: lid ?? this.lid,
        period: period ?? this.period,
        status: status ?? this.status,
        licensesList: licensesList ?? this.licensesList,
      );
}
