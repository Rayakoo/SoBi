import 'package:flutter/material.dart';
import 'package:sobi/features/presentation/router/app_router.dart';
import 'dart:convert';
import '../../data/models/user_model.dart';
import '../../data/datasources/auth_datasources.dart';
import '../../domain/usecases/auth/sign_in.dart';
import '../../domain/usecases/auth/sign_up.dart';
import '../../domain/usecases/auth/verify_otp.dart';
import '../../domain/usecases/auth/logout.dart';
import '../../domain/usecases/user/get_user.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? user;
  String? token;
  String? error;
  bool isLoading = false;

  final SignIn signInUsecase;
  final SignUp signUpUsecase;
  final VerifyOtp verifyOtpUsecase;
  final Logout logoutUsecase;
  final GetUser getUserUsecase;

  final AuthDatasources authDatasources = AuthDatasources();

  AuthProvider({
    required this.signInUsecase,
    required this.signUpUsecase,
    required this.verifyOtpUsecase,
    required this.logoutUsecase,
    required this.getUserUsecase,
  }) {
    _initUserFromCacheOrApi();
  }

  Future<void> _initUserFromCacheOrApi() async {
    final token = await authDatasources.getToken();
    if (token != null && token.isNotEmpty) {
      // Fetch user dari API dan update cache
      user = await authDatasources.fetchAndCacheUser();
      if (user == null) {
        // fallback ke cache jika API gagal
        user = await authDatasources.getCachedUser();
      }
      this.token = token;
      notifyListeners();
    } else {
      user = null;
      this.token = null;
      notifyListeners();
    }
  }

  Future<void> signIn(String email, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      final result = await signInUsecase(email: email, password: password);
      if (result['token'] != null) {
        token = result['token'];
        user = result['user'];
        error = null;
        await checkLoginStatus(); // <--- trigger router refresh
        notifyListeners();
      } else {
        error = result['message'] ?? 'Login gagal';
        notifyListeners();
      }
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> signUp(
    String email,
    String username,
    String phone,
    String password,
  ) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      await signUpUsecase(
        email: email,
        username: username,
        phone: phone,
        password: password,
      );
      error = null;
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> verifyOtp(String email, String otp) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      await verifyOtpUsecase(email: email, otp: otp);
      error = null;
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchUser() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      user = await authDatasources.fetchAndCacheUser();
      error = null;
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      await logoutUsecase();
      user = null;
      token = null;
      error = null;
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
