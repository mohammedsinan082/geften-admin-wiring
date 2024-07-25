import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/failure.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(
    firestore: FirebaseFirestore.instance,
    ref: ref,
  );
});

class AuthRepository {
  final FirebaseFirestore _firestore;
  final Ref _ref;

  AuthRepository({
    required FirebaseFirestore firestore,
    required Ref ref,
  })  : _firestore = firestore,
        _ref = ref;

  Future<Either<Failure, DocumentSnapshot>> adminLogin({
    required String email,
    required String password,
  }) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection("admin")
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final adminDoc = snapshot.docs.first;
        return right(adminDoc);
      } else {
        return left(Failure("Invalid Email/Password"));
      }
    } on FirebaseException catch (e) {
      return left(Failure(e.message ?? "An error occurred"));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
