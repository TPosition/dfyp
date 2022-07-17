part of 'compounds_bloc.dart';

abstract class CompoundsEvent extends Equatable {
  const CompoundsEvent();

  @override
  List<Object> get props => [];
}

class LoadCompounds extends CompoundsEvent {}

class AddCompound extends CompoundsEvent {
  final Compound compound;

  const AddCompound(this.compound);

  @override
  List<Object> get props => [compound];

  @override
  String toString() => 'AddCompound { compound: $compound }';
}

class UpdateCompound extends CompoundsEvent {
  final Compound updatedCompound;

  const UpdateCompound(this.updatedCompound);

  @override
  List<Object> get props => [updatedCompound];

  @override
  String toString() => 'UpdateCompound { updatedCompound: $updatedCompound }';
}

class CompoundsUpdated extends CompoundsEvent {
  final List<Compound> compounds;

  const CompoundsUpdated(this.compounds);

  @override
  List<Object> get props => [compounds];
}

// class DeleteCompound extends CompoundsEvent {
//   final Compound compound;

//   const DeleteCompound(this.compound);

//   @override
//   List<Object> get props => [compound];

//   @override
//   String toString() => 'DeleteCompound { compound: $compound }';
// }
