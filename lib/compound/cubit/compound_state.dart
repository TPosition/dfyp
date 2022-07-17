part of 'compound_cubit.dart';

class CompoundState extends Equatable {
  const CompoundState({
    required final this.selectedCompound,
    final this.compoundsList = const [],
    final this.filteredCompoundsList = const [],
    final this.status = FormzStatus.pure,
    final this.isSuccess = false,
  });

  final List<Compound> compoundsList;
  final List<Compound?> filteredCompoundsList;
  final FormzStatus status;
  final Compound selectedCompound;
  final bool isSuccess;

  @override
  List<Object> get props => [
        compoundsList,
        filteredCompoundsList,
        status,
        selectedCompound,
        isSuccess
      ];

  CompoundState copyWith({
    final List<Compound>? compoundsList,
    final List<Compound?>? filteredCompoundsList,
    final FormzStatus? status,
    final Compound? selectedCompound,
  }) =>
      CompoundState(
        selectedCompound: selectedCompound ?? this.selectedCompound,
        status: status ?? this.status,
        compoundsList: compoundsList ?? this.compoundsList,
        filteredCompoundsList:
            filteredCompoundsList ?? this.filteredCompoundsList,
      );
}
