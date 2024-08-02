class UserModel {
  final String name;
  String? imageUrl;
  final String mobileNumber;
  String? aadharNumber;
  BankAccountDetails bankAccountDetails;
  final bool isApproved;
  final String place;
  final String address;
  final String district;
  final String state;
  final String pinCode;
  bool isdeleted;
  final bool isGoldMember;
  bool? isLoyaltyPointAchieved;
  bool? isChannelPartnrReccommended;
  bool? isSupportGeften;
  String? insuranceNumber;
  int? loyaltyPoints;
  int? rewardPOints;
  List? scannedRewardPoints;
  List? scannedLoyaltyPoints;
  List? redeemedRewardPoints;
  List? redeemedLoyaltyPoints;
  String? pdfUrl;
  UserModel({
    required this.name,
    required this.mobileNumber,
    this.imageUrl,
    this.aadharNumber,
    required this.bankAccountDetails,
    required this.isApproved,
    required this.place,
    required this.address,
    required this.pinCode,
    required this.district,
    required this.state,
    required this.isdeleted,
    required this.isGoldMember,
    this.isLoyaltyPointAchieved,
    this.isSupportGeften,
    this.isChannelPartnrReccommended,
    this.insuranceNumber,
    this.loyaltyPoints,
    this.rewardPOints,
    this.scannedRewardPoints,
    this.scannedLoyaltyPoints,
    this.redeemedRewardPoints,
    this.redeemedLoyaltyPoints,
    this.pdfUrl,
  });

  UserModel copyWith({
    String? name,
    String? mobileNumber,
    String? imageUrl,
    String? aadharNumber,
    BankAccountDetails? bankAccountDetails,
    bool? isApproved,
    String? place,
    String? address,
    String? pinCode,
    String? district,
    String? state,
    bool? isdeleted,
    bool? isGoldMember,
    bool? isLoyaltyPointAchieved,
    bool? isChannelPartnrReccommended,
    bool? isSupportGeften,
    String? insuranceNumber,
    int? loyaltyPoints,
    int? rewardPOints,
    List? scannedRewardPoints,
    List? scannedLoyaltyPoints,
    List? redeemedRewardPoints,
    List? redeemedLoyaltyPoints,
    String? pdfUrl,
  }) {
    return UserModel(
      name: name ?? this.name,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      imageUrl: imageUrl ?? this.imageUrl,
      aadharNumber: aadharNumber ?? this.aadharNumber,
      bankAccountDetails: bankAccountDetails ?? this.bankAccountDetails,
      isApproved: isApproved ?? this.isApproved,
      place: place ?? this.place,
      address: address ?? this.address,
      pinCode: pinCode ?? this.pinCode,
      district: district ?? this.district,
      state: state ?? this.state,
      isdeleted: isdeleted ?? this.isdeleted,
      isGoldMember: isGoldMember ?? this.isGoldMember,
      isLoyaltyPointAchieved: isLoyaltyPointAchieved ?? this.isLoyaltyPointAchieved,
      isSupportGeften: isSupportGeften ?? this.isSupportGeften,
      isChannelPartnrReccommended: isChannelPartnrReccommended ?? this.isChannelPartnrReccommended,
      insuranceNumber: insuranceNumber ?? this.insuranceNumber,
      loyaltyPoints: loyaltyPoints ?? this.loyaltyPoints,
      rewardPOints: rewardPOints ?? this.rewardPOints,
      scannedRewardPoints: scannedRewardPoints ?? this.scannedRewardPoints,
      scannedLoyaltyPoints: scannedLoyaltyPoints ?? this.scannedLoyaltyPoints,
      redeemedRewardPoints: redeemedRewardPoints ?? this.redeemedRewardPoints,
      redeemedLoyaltyPoints:
      redeemedLoyaltyPoints ?? this.redeemedLoyaltyPoints,
      pdfUrl: pdfUrl ?? this.pdfUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'mobileNumber': mobileNumber,
      'aadharNumber': aadharNumber ?? '',
      'imageUrl': imageUrl ?? '',
      'bankAccountDetails': bankAccountDetails.toJson(),
      'isApproved': isApproved,
      'place': place,
      'address': address,
      'pinCode': pinCode,
      'district': district,
      'state': state,
      'isdeleted': isdeleted,
      'isGoldMember': isGoldMember,
      'isLoyaltyPointAchieved': isLoyaltyPointAchieved ?? false,
      'isSupportGeften': isSupportGeften ?? false,
      'isChannelPartnrReccommended': isChannelPartnrReccommended ?? false,
      'insuranceNumber': insuranceNumber ?? '',
      'loyaltyPoints': loyaltyPoints ?? 0,
      'rewardPoints': rewardPOints ?? 0,
      'scannedRewardPoints': scannedRewardPoints ?? [],
      'scannedLoyaltyPoints': scannedLoyaltyPoints ?? [],
      'redeemedRewardPoints': redeemedRewardPoints ?? [],
      'redeemedLoyaltyPoints': redeemedLoyaltyPoints ?? [],
      'pdfUrl': pdfUrl ?? '',
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      mobileNumber: json['mobileNumber'],
      imageUrl: json['imageUrl'],
      aadharNumber: json['aadharNumber'] ?? '',
      bankAccountDetails:
      BankAccountDetails.fromJson(json['bankAccountDetails'] ?? {}),
      isApproved: json['isApproved'],
      place: json['place'],
      address: json['address'],
      pinCode: json['pinCode'],
      district: json['district'],
      state: json['state'],
      isdeleted: json['isdeleted'],
      isGoldMember: json['isGoldMember'],
      isLoyaltyPointAchieved: json['isLoyaltyPointAchieved'],
      isSupportGeften: json['isSupportGeften'],
      isChannelPartnrReccommended: json['isChannelPartnrReccommended'],
      insuranceNumber: json['insuranceNumber'] ?? '',
      loyaltyPoints: json['loyaltyPoints'] ?? 0,
      rewardPOints: json['rewardPoints'] ?? 0,
      scannedRewardPoints: json['scannedRewardPoints'],
      scannedLoyaltyPoints: json['scannedLoyaltyPoints'],
      redeemedRewardPoints: json['redeemedRewardPoints'],
      redeemedLoyaltyPoints: json['redeemedLoyaltyPoints'],
      pdfUrl: json['pdfUrl'] ?? '',
    );
  }
}

class BankAccountDetails {
  String? bankAccountNumber;
  String? bankName;
  String? ifscCode;
  BankAccountDetails({
    this.bankAccountNumber,
    this.bankName,
    this.ifscCode,
  });

  BankAccountDetails copyWith({
    String? bankAccountNumber,
    String? bankName,
    String? ifscCode,
  }) {
    return BankAccountDetails(
      bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
      bankName: bankName ?? this.bankName,
      ifscCode: ifscCode ?? this.ifscCode,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'bankAccountNumber': bankAccountNumber ?? '',
      'bankName': bankName ?? '',
      'ifscCode': ifscCode ?? '',
    };
  }

  factory BankAccountDetails.fromJson(Map<String, dynamic> json) {
    return BankAccountDetails(
      bankAccountNumber: json['bankAccountNumber'] ?? '',
      bankName: json['bankName'] ?? '',
      ifscCode: json['ifscCode'] ?? '',
    );
  }
}

class ScannedPoints {
  String? qrNumber;
  int? points;
  DateTime? scannedDate;
  ScannedPoints({
    this.qrNumber,
    this.points,
    this.scannedDate,
  });

  ScannedPoints copyWith({
    String? qrNumber,
    int? points,
    DateTime? scannedDate,
  }) {
    return ScannedPoints(
      qrNumber: qrNumber ?? this.qrNumber,
      points: points ?? this.points,
      scannedDate: scannedDate ?? this.scannedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'qrNumber': qrNumber ?? '',
      'points': points ?? 0,
      'scannedDate': scannedDate ?? DateTime.now(),
    };
  }

  factory ScannedPoints.fromMap(Map<String, dynamic> map) {
    return ScannedPoints(
      qrNumber: map['qrNumber'],
      points: map['points'],
      scannedDate: map['scannedDate'].toDate(),
    );
  }
}

class RedeemedPoints {
  int? redeemedPoints;
  DateTime? redeemedDate;
  RedeemedPoints({
    this.redeemedPoints,
    this.redeemedDate,
  });

  RedeemedPoints copyWith({
    int? redeemedPoints,
    DateTime? redeemedDate,
  }) {
    return RedeemedPoints(
      redeemedPoints: redeemedPoints ?? this.redeemedPoints,
      redeemedDate: redeemedDate ?? this.redeemedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'redeemedPoints': redeemedPoints ?? 0,
      'redeemedDate': redeemedDate ?? DateTime.now(),
    };
  }

  factory RedeemedPoints.fromMap(Map<String, dynamic> map) {
    return RedeemedPoints(
      redeemedPoints: map['redeemedPoints'],
      redeemedDate: map['redeemedDate'].toDate(),
    );
  }
}