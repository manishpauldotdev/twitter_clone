import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/auth_api.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/auth/views/login_view.dart';
import 'package:twitter_clone/features/home/view/home_view.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(authApi: ref.watch(authApiProvider));
});

class AuthController extends StateNotifier<bool> {
  final AuthApi _authApi;

  AuthController({required AuthApi authApi})
      : _authApi = authApi,
        super(false);

  // state = isLoading here

  void signup({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final response = await _authApi.signup(email: email, password: password);
    state = false;
    response.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
        showSnackBar(context, 'Account Created! Please log in');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginView.route(),
          ),
        );
      },
    );
  }

  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final response = await _authApi.login(email: email, password: password);
    state = false;
    response.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
        showSnackBar(context, 'Login Successful!');
        Navigator.push(
          context,
          HomeView.route(),
        );
      },
    );
  }
}
