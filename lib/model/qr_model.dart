class GenerateQrCodeModel {
  String? id;
  String? batchId;
  String? QrNumber;
  String? ScanStatus;
  int? RewardPoint;
  int? Loyaltyint;
  DateTime? CreatedDate;
  DateTime? ExportedDate;
  bool? ExportStatus;
  DateTime? ScannedDate;

  GenerateQrCodeModel({
    this.id,
    this.batchId,
    this.QrNumber,
    this.ScanStatus,
    this.RewardPoint,
    this.Loyaltyint,
    this.CreatedDate,
    this.ExportedDate,
    this.ExportStatus,
    this.ScannedDate,
  });

  GenerateQrCodeModel copyWith({
    String? id,
    String? batchId,
    String? QrNumber,
    String? ScanStatus,
    int? RewardPoint,
    int? Loyaltyint,
    DateTime? CreatedDate,
    DateTime? ExportedDate,
    bool? ExportStatus,
    DateTime? ScannedDate,
  }) {
    return GenerateQrCodeModel(
      id: id ?? this.id,
      batchId: batchId ?? this.batchId,
      QrNumber: QrNumber ?? this.QrNumber,
      ScanStatus: ScanStatus ?? this.ScanStatus,
      RewardPoint: RewardPoint ?? this.RewardPoint,
      Loyaltyint: Loyaltyint ?? this.Loyaltyint,
      CreatedDate: CreatedDate ?? this.CreatedDate,
      ExportedDate: ExportedDate ?? this.ExportedDate,
      ExportStatus: ExportStatus ?? this.ExportStatus,
      ScannedDate: ScannedDate ?? this.ScannedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'batchId': batchId,
      'QrNumber': QrNumber,
      'ScanStatus': ScanStatus,
      'RewardPoint': RewardPoint,
      'Loyaltyint': Loyaltyint,
      'CreatedDate': CreatedDate?.toIso8601String(),
      'ExportedDate': ExportedDate?.toIso8601String(),
      'ExportStatus': ExportStatus,
      'ScannedDate': ScannedDate?.toIso8601String(),
    };
  }

  factory GenerateQrCodeModel.fromMap(Map<String, dynamic> map) {
    return GenerateQrCodeModel(
      id: map['id'] as String?,
      batchId: map['batchId'],
      QrNumber: map['QrNumber'] as String?,
      ScanStatus: map['ScanStatus'] as String?,
      RewardPoint: map['RewardPoint'] as int?,
      Loyaltyint: map['Loyaltyint'] as int?,
      CreatedDate: map['CreatedDate'] != null ? DateTime.parse(map['CreatedDate']) : null,
      ExportedDate: map['ExportedDate'] != null ? DateTime.parse(map['ExportedDate']) : null,
      ExportStatus: map['ExportStatus'] as bool?,
      ScannedDate: map['ScannedDate'] != null ? DateTime.parse(map['ScannedDate']) : null,
    );
  }
}
