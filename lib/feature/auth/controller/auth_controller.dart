import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../home/home_page.dart';
import '../repository/auth_repository.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(repository: ref.read(authRepositoryProvider), ref: ref);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _repository;
  final Ref _ref;

  AuthController({required AuthRepository repository, required Ref ref})
      : _repository = repository,
        _ref = ref,
        super(false);

  void adminLogin({
    required String email,
    required String password,
    required BuildContext context,
    required Function(BuildContext context, String message) alertBox,
  }) async {
    state = true;
    final user = await _repository.adminLogin(email: email, password: password);
    state = false;

    user.fold((failure) {
      alertBox(context, failure.message);
    }, (adminDoc) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false,
      );
    });
  }
}
