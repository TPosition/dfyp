part of 'complaints_bloc.dart';

abstract class ComplaintsEvent extends Equatable {
  const ComplaintsEvent();

  @override
  List<Object> get props => [];
}

class LoadComplaints extends ComplaintsEvent {}

class AddComplaint extends ComplaintsEvent {
  final Complaint complaint;

  const AddComplaint(this.complaint);

  @override
  List<Object> get props => [complaint];

  @override
  String toString() => 'AddComplaint { complaint: $complaint }';
}

class UpdateComplaint extends ComplaintsEvent {
  final Complaint updatedComplaint;

  const UpdateComplaint(this.updatedComplaint);

  @override
  List<Object> get props => [updatedComplaint];

  @override
  String toString() =>
      'UpdateComplaint { updatedComplaint: $updatedComplaint }';
}

class ComplaintsUpdated extends ComplaintsEvent {
  final List<Complaint> complaints;

  const ComplaintsUpdated(this.complaints);

  @override
  List<Object> get props => [complaints];
}

// class DeleteComplaint extends ComplaintsEvent {
//   final Complaint complaint;

//   const DeleteComplaint(this.complaint);

//   @override
//   List<Object> get props => [complaint];

//   @override
//   String toString() => 'DeleteComplaint { complaint: $complaint }';
// }
