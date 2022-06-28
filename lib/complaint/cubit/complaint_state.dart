part of 'complaint_cubit.dart';

class ComplaintState extends Equatable {
  const ComplaintState({
    this.title = '',
    this.comment = '',
  });

  final String title;
  final String comment;

  @override
  List<Object> get props => [title, comment];

  ComplaintState copyWith({
    String? title,
    String? comment,
    FormzStatus? status,
  }) {
    return ComplaintState(
      title: title ?? this.title,
      comment: comment ?? this.comment,
    );
  }
}
