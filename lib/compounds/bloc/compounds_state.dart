part of 'compounds_bloc.dart';

abstract class CompoundsState extends Equatable {
  const CompoundsState();

  @override
  List<Object> get props => [];
}

class CompoundsLoading extends CompoundsState {}

class CompoundsLoaded extends CompoundsState {
  final List<Compound> compounds;

  const CompoundsLoaded([this.compounds = const []]);

  @override
  List<Object> get props => [compounds];

  @override
  String toString() => 'CompoundsLoaded { compounds: $compounds }';
}

class CompoundsInitial extends CompoundsState {}
