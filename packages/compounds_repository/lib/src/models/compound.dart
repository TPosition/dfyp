import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
import '../entities/entities.dart';

@immutable
class Compound {
  final String id;
  final double amount;
  final String reason;
  final String agency;
  final DateTime timestamp;

  Compound(
      {String? id,
      required this.amount,
      required this.reason,
      required this.agency,
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
        amount.hashCode ^
        reason.hashCode ^
        agency.hashCode ^
        timestamp.hashCode;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Compound &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            amount == other.amount &&
            reason == other.reason &&
            agency == other.agency &&
            timestamp == other.timestamp;
  }

  @override
  String toString() {
    return 'Compound{id: $id,amount: $amount,reason: $reason,agency: $agency,timestamp: $timestamp}';
  }

  CompoundEntity toEntity() {
    return CompoundEntity(
        id: id,
        amount: amount,
        reason: reason,
        agency: agency,
        timestamp: timestamp);
  }

  static Compound fromEntity(CompoundEntity entity) {
    return Compound(
      id: entity.id,
      amount: entity.amount,
      reason: entity.reason,
      agency: entity.agency,
      timestamp: entity.timestamp,
    );
  }
}
