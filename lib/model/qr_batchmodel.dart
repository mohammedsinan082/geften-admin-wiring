import 'package:cloud_firestore/cloud_firestore.dart';

class QrBatchmodel {
  String? batchId;
  DateTime? createdDate;
  bool? status;
  String? batchStatus;

  QrBatchmodel({
    this.batchId,
    this.createdDate,
    this.status = false, // Default to false
    this.batchStatus,
  });

  QrBatchmodel copyWith({
    String? batchId,
    DateTime? createdDate,
    bool? status,
    String? batchStatus,
  }) {
    return QrBatchmodel(
      batchId: batchId ?? this.batchId,
      createdDate: createdDate ?? this.createdDate,
      status: status ?? this.status,
      batchStatus: batchStatus ?? this.batchStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'batchId': batchId,
      'createdDate': createdDate != null ? Timestamp.fromDate(createdDate!) : null,
      'status': status ?? false,
      'batchStatus': batchStatus,
    };
  }

  factory QrBatchmodel.fromMap(Map<String, dynamic> map) {
    return QrBatchmodel(
      batchId: map['batchId'] as String?,
      createdDate: map['createdDate'] != null ? (map['createdDate'] as Timestamp).toDate() : null,
      status: map['status'] as bool? ?? false,
      batchStatus: map['batchStatus'] as String?,
    );
  }
}
