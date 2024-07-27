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
  String? insuranceNumber;
  int? loyaltyPoints;
  int? rewardPOints;
  int? redeemedPoints;
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
    this.insuranceNumber,
    this.loyaltyPoints,
    this.rewardPOints,
    this.redeemedPoints,
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
    String? insuranceNumber,
    int? loyaltyPoints,
    int? rewardPOints,
    int? redeemedPoints,
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
      insuranceNumber: insuranceNumber ?? this.insuranceNumber,
      loyaltyPoints: loyaltyPoints ?? this.loyaltyPoints,
      rewardPOints: rewardPOints ?? this.rewardPOints,
      redeemedPoints: redeemedPoints ?? this.redeemedPoints,
      pdfUrl: pdfUrl ?? this.pdfUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'mobileNumber': mobileNumber,
      'aadharNumber': aadharNumber,
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
      'insuranceNumber': insuranceNumber ?? '',
      'loyaltyPoints': loyaltyPoints ?? 0,
      'rewardPoints': rewardPOints ?? 0,
      'redeemPoints': redeemedPoints ?? 0,
      'pdfUrl': pdfUrl,
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
      insuranceNumber: json['insuranceNumber'] ?? '',
      loyaltyPoints: json['loyaltyPoints'] ?? 0,
      rewardPOints: json['rewardPoints'] ?? 0,
      redeemedPoints: json['redeemPoints'] ?? 0,
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