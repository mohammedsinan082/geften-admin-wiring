import 'package:cloud_firestore/cloud_firestore.dart';

class Advertisement {
  final String id;
  final String imageUrl;
  final String description;

  //<editor-fold desc="Data Methods">
  const Advertisement({
    required this.id,
    required this.imageUrl,
    required this.description,
  });

  Advertisement copyWith({
    String? id,
    String? imageUrl,
    String? description,
  }) {
    return Advertisement(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'description': description,
    };
  }

  factory Advertisement.fromMap(Map<String, dynamic> map) {
    return Advertisement(
      id: map['id'] as String,
      imageUrl: map['imageUrl'] as String,
      description: map['description'] as String,
    );
  }

  static Future<bool> isUrlDuplicate(String url) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('advertisements')
        .where('imageUrl', isEqualTo: url)
        .get();
    return querySnapshot.docs.isNotEmpty;
  }

  Future<void> saveToFirestore() async {
    await FirebaseFirestore.instance
        .collection('advertisements')
        .doc(id)
        .set(toMap());
  }
//</editor-fold>
}
