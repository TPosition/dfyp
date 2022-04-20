part of 'application_cubit.dart';

class ApplicationState extends Equatable {
  const ApplicationState({
    final this.type = 'LDL',
    final this.lclass = 'A',
    final this.period = 1,
    final this.department = 'APAD',
    final this.status = FormzStatus.pure,
  }) : amount = period * 60;

  final String type;
  final String lclass;
  final int period;
  final String department;
  final FormzStatus status;
  final int amount;

  @override
  List<Object> get props => [
        type,
        lclass,
        period,
        department,
        status,
      ];

  ApplicationState copyWith({
    final String? type,
    final String? lclass,
    final int? period,
    final String? department,
    final FormzStatus? status,
  }) =>
      ApplicationState(
        type: type ?? this.type,
        lclass: lclass ?? this.lclass,
        period: period ?? this.period,
        department: department ?? this.department,
        status: status ?? this.status,
      );
}
