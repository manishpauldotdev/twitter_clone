import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/auth_api.dart';
import 'package:twitter_clone/apis/user_api.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/auth/views/login_view.dart';
import 'package:twitter_clone/features/home/view/home_view.dart';
import 'package:appwrite/models.dart' as model;
import 'package:twitter_clone/models/user_model.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authApi: ref.watch(authApiProvider),
    userApi: ref.watch(userAPIProvider),
  );
});

final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);

  return authController.currentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthApi _authApi;
  final UserApi _userApi;

  AuthController({required AuthApi authApi, required UserApi userApi})
      : _authApi = authApi,
        _userApi = userApi,
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
      (r) async {
        UserModel userModel = UserModel(
          email: email,
          name: getNameFromEmail(email),
          followers: const [],
          following: const [],
          profilePicture: '',
          bannerPicture: '',
          uid: '',
          bio: '',
          isTwitterBlue: false,
        );
        final res = await _userApi.saveUserData(userModel);

        res.fold(
          (l) => showSnackBar(context, l.message),
          (r) {
            showSnackBar(context, 'Account Created! Please log in');
            Navigator.push(
              context,
              LoginView.route(),
            );
          },
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

  Future<model.User?> currentUser() => _authApi.currentUserAccount();
}
