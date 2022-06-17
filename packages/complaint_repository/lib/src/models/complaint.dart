import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
import '../entities/entities.dart';

@immutable
class Complaint {
  final String id;
  final String uid;
  final String title;
  final String comment;
  final DateTime timestamp;

  Complaint(
      {String? id,
      required this.uid,
      required this.title,
      required this.comment,
      DateTime? timestamp})
      : this.id = id ?? Uuid().v4(),
        this.timestamp = timestamp ?? DateTime.now();

  // Complaint copyWith({bool? complete, String? note, String? task}) {
  //   return Complaint(
  //     id: id,
  //     task: task ?? this.task,
  //     complete: complete ?? this.complete,
  //     note: note ?? this.note,
  //   );
  // }

  @override
  int get hashCode {
    return id.hashCode ^
        uid.hashCode ^
        title.hashCode ^
        comment.hashCode ^
        timestamp.hashCode;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Complaint &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            uid == other.uid &&
            title == other.title &&
            comment == other.comment &&
            timestamp == other.timestamp;
  }

  @override
  String toString() {
    return 'Complaint{id: $id,uid: $uid,title: $title,comment: $comment}';
  }

  ComplaintEntity toEntity() {
    return ComplaintEntity(
        id: id, uid: uid, title: title, comment: comment, timestamp: timestamp);
  }

  static Complaint fromEntity(ComplaintEntity entity) {
    return Complaint(
      id: entity.id,
      uid: entity.uid,
      title: entity.title,
      comment: entity.comment,
      timestamp: entity.timestamp,
    );
  }
}
