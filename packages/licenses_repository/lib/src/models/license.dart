import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
import '../entities/entities.dart';

@immutable
class License {
  final String id;
  final String uid;
  final String type;
  final String lclass;
  final int period;
  final String department;
  final DateTime expiry;
  final String status;
  final DateTime timestamp;

  License(
      {final String? id,
      required this.uid,
      required this.type,
      required this.lclass,
      required this.period,
      required this.department,
      required this.expiry,
      required this.status,
      final DateTime? timestamp})
      : this.id = id ?? Uuid().v4(),
        this.timestamp = timestamp ?? DateTime.now();

  License copyWith({
    final String? type,
    final String? lclass,
    final int? period,
    final String? department,
    final DateTime? expiry,
    final String? status,
  }) =>
      License(
        id: id,
        uid: uid,
        type: type ?? this.type,
        lclass: lclass ?? this.lclass,
        period: period ?? this.period,
        department: department ?? this.department,
        expiry: expiry ?? this.expiry,
        status: status ?? this.status,
        timestamp: timestamp,
      );

  @override
  int get hashCode =>
      id.hashCode ^
      uid.hashCode ^
      type.hashCode ^
      lclass.hashCode ^
      period.hashCode ^
      department.hashCode ^
      expiry.hashCode ^
      status.hashCode ^
      timestamp.hashCode;

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is License &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          uid == other.uid &&
          type == other.type &&
          lclass == other.lclass &&
          period == other.period &&
          department == other.department &&
          expiry == other.expiry &&
          status == other.status &&
          timestamp == other.timestamp;

  @override
  String toString() =>
      'LicenseEntity { id: $id,uid: $uid, type: $type, lclass: $lclass, period: $period, department: $department, expiry: $expiry, status: $status,timestamp: $timestamp }';

  LicenseEntity toEntity() => LicenseEntity(
      id: id,
      uid: uid,
      type: type,
      lclass: lclass,
      period: period,
      department: department,
      expiry: expiry,
      status: status,
      timestamp: timestamp);

  static License fromEntity(final LicenseEntity entity) => License(
        id: entity.id,
        uid: entity.uid,
        type: entity.type,
        lclass: entity.lclass,
        period: entity.period,
        department: entity.department,
        expiry: entity.expiry,
        status: entity.status,
        timestamp: entity.timestamp,
      );

  // static License empty() => const License(
  //       department: '',
  //       expiry: DateTime.now(),
  //       lclass: '',
  //       period: 0,
  //       status: 'pending',
  //       type: '',
  //       uid: '',
  //     );
}
