import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
import '../entities/entities.dart';

@immutable
class Transaction {
  final String id;
  final double amount;
  final String category;
  final String receiverDisplayName;
  final String receiverUID;
  final String senderDisplayName;
  final String senderUID;
  final DateTime timestamp;

  Transaction(
      {String? id,
      required this.amount,
      required this.category,
      required this.receiverDisplayName,
      required this.receiverUID,
      this.senderUID = "",
      this.senderDisplayName = "",
      DateTime? timestamp})
      : this.id = id ?? Uuid().v4(),
        this.timestamp = timestamp ?? DateTime.now();

  // Transaction copyWith({bool? complete, String? note, String? task}) {
  //   return Transaction(
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
        category.hashCode ^
        receiverDisplayName.hashCode ^
        receiverUID.hashCode ^
        senderUID.hashCode ^
        senderDisplayName.hashCode ^
        timestamp.hashCode;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Transaction &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            amount == other.amount &&
            category == other.category &&
            receiverDisplayName == other.receiverDisplayName &&
            receiverUID == other.receiverUID &&
            senderUID == other.senderUID &&
            senderDisplayName == other.senderDisplayName &&
            timestamp == other.timestamp;
  }

  @override
  String toString() {
    return 'Transaction{id: $id,amount: $amount,category: $category,receiverDisplayName: $receiverDisplayName,receiverUID: $receiverUID,senderUID: $senderUID,senderDisplayName: $senderDisplayName,timestamp: $timestamp}';
  }

  TransactionEntity toEntity() {
    return TransactionEntity(
        id: id,
        amount: amount,
        category: category,
        receiverDisplayName: receiverDisplayName,
        receiverUID: receiverUID,
        senderDisplayName: senderDisplayName,
        senderUID: senderUID,
        timestamp: timestamp);
  }

  static Transaction fromEntity(TransactionEntity entity) {
    return Transaction(
      id: entity.id,
      amount: entity.amount,
      category: entity.category,
      receiverDisplayName: entity.receiverDisplayName,
      receiverUID: entity.receiverUID,
      senderUID: entity.senderUID,
      senderDisplayName: entity.senderDisplayName,
      timestamp: entity.timestamp,
    );
  }
}
