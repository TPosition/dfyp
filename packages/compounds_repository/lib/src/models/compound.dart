import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
import '../entities/entities.dart';

@immutable
class Compound {
  final String id;
  final String uid;
  final num amount;
  final String reason;
  final String agency;
  final String plate;
  final DateTime timestamp;
  final bool isPaid;

  Compound(
      {String? id,
      required this.uid,
      required this.amount,
      required this.reason,
      required this.agency,
      required this.plate,
      required this.isPaid,
      DateTime? timestamp})
      : this.id = id ?? Uuid().v4(),
        this.timestamp = timestamp ?? DateTime.now();

  // Compound copyWith({bool? complete, String? note, String? task}) {
  //   return Compound(
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
        amount.hashCode ^
        reason.hashCode ^
        agency.hashCode ^
        plate.hashCode ^
        isPaid.hashCode ^
        timestamp.hashCode;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Compound &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            uid == other.uid &&
            amount == other.amount &&
            reason == other.reason &&
            agency == other.agency &&
            plate == other.plate &&
            isPaid == other.isPaid &&
            timestamp == other.timestamp;
  }

  @override
  String toString() {
    return 'Compound{id: $id,uid:$uid,amount: $amount,reason: $reason,agency: $agency,plate: $plate, timestamp: $timestamp, isPaid:$isPaid,}';
  }

  CompoundEntity toEntity() {
    return CompoundEntity(
        id: id,
        uid: uid,
        amount: amount,
        reason: reason,
        agency: agency,
        plate: plate,
        isPaid: isPaid,
        timestamp: timestamp);
  }

  static Compound fromEntity(CompoundEntity entity) {
    return Compound(
      id: entity.id,
      uid: entity.uid,
      amount: entity.amount,
      reason: entity.reason,
      agency: entity.agency,
      plate: entity.plate,
      isPaid: entity.isPaid,
      timestamp: entity.timestamp,
    );
  }
}
