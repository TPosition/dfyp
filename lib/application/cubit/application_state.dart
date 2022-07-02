part of 'application_cubit.dart';

class ApplicationState extends Equatable {
  const ApplicationState({
    final this.type = 'LDL',
    final this.lclass = 'D',
    final this.period = 3,
    final this.department = 'APAD',
    final this.status = FormzStatus.pure,
    final this.isCar = true,
  }) : amount = period * 10;

  final String type;
  final String lclass;
  final int period;
  final String department;
  final FormzStatus status;
  final int amount;
  final bool isCar;

  @override
  List<Object> get props => [
        type,
        lclass,
        period,
        department,
        status,
        isCar,
      ];

  ApplicationState copyWith({
    final String? type,
    final String? lclass,
    final int? period,
    final String? department,
    final FormzStatus? status,
    final bool? isCar,
  }) =>
      ApplicationState(
        type: type ?? this.type,
        lclass: lclass ?? this.lclass,
        period: period ?? this.period,
        department: department ?? this.department,
        status: status ?? this.status,
        isCar: isCar ?? this.isCar,
      );
}
