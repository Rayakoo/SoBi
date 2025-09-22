import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/user_model.dart';

class AuthDatasources {
  final Dio dio;
  final FlutterSecureStorage storage;
  final String baseUrl;

  AuthDatasources({
    Dio? dioClient,
    FlutterSecureStorage? secureStorage,
    String? baseUrlOverride,
  }) : dio = dioClient ?? Dio(),
       storage = secureStorage ?? const FlutterSecureStorage(),
       baseUrl = baseUrlOverride ?? dotenv.env['BASE_URL'] ?? '' {
    // BYPASS SSL UNTUK DEVELOPMENT/TESTING
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (
      HttpClient client,
    ) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  // Signup
  Future<String> signup({
    required String email,
    required String username,
    required String phone,
    required String password,
  }) async {
    final requestBody = {
      'email': email,
      'username': username,
      'phone': phone,
      'password': password,
    };
    print('DEBUG signup request: $requestBody');
    try {
      final res = await dio.post('$baseUrl/signup', data: requestBody);
      print('DEBUG signup response: ${res.data}');
      return res.data['message'] ?? '';
    } catch (e) {
      print('DEBUG signup error: $e');
      if (e is DioError) {
        print('DEBUG signup error response: ${e.response?.data}');
      }
      rethrow;
    }
  }

  // Verify OTP
  Future<String> verifyOtp({required String email, required String otp}) async {
    final requestBody = {'email': email, 'otp': otp};
    print('DEBUG verifyOtp request: $requestBody');
    try {
      final res = await dio.post('$baseUrl/verify-otp', data: requestBody);
      print('DEBUG verifyOtp response: ${res.data}');
      return res.data['message'] ?? '';
    } catch (e) {
      print('DEBUG verifyOtp error: $e');
      if (e is DioError) {
        print('DEBUG verifyOtp error response: ${e.response?.data}');
      }
      rethrow;
    }
  }

  // Helper untuk debug isi storage
  Future<void> debugPrintStorage() async {
    final allKeys = await storage.readAll();
    print('=== STORAGE CONTENT ===');
    allKeys.forEach((key, value) {
      print('$key: $value');
    });
    print('=======================');
  }

  // Signin: hanya simpan token, lalu fetch user profile dan simpan ke cache
  Future<Map<String, dynamic>> signin({
    required String email,
    required String password,
  }) async {
    final res = await dio.post(
      '$baseUrl/signin',
      data: {'email': email, 'password': password},
    );
    final data = res.data;
    final token = data['access_token'] ?? '';
    final refreshToken = data['refresh_token'] ?? '';
    final expiresIn = data['expires_in'] ?? 0;

    print('DEBUG signin response: $data');
    if (token.isNotEmpty) {
      await storage.write(key: 'auth_token', value: token);
      print('DEBUG token saved: $token');
      await storage.write(key: 'refresh_token', value: refreshToken);
      print('DEBUG refreshToken saved: $refreshToken');
      await storage.write(key: 'expires_in', value: expiresIn.toString());
      print('DEBUG expiresIn saved: $expiresIn');
      // Fetch user profile dan simpan ke cache
      final user = await getUser();
      await storage.write(key: 'user_data', value: jsonEncode(user.toJson()));
      print('DEBUG user (from getUser) saved: ${user.toJson()}');
      return {
        'token': token,
        'refresh_token': refreshToken,
        'expires_in': expiresIn,
        'user': user,
        'message': data['message'] ?? '',
      };
    } else {
      print('DEBUG token is empty, not saved');
      return {
        'token': null,
        'refresh_token': null,
        'expires_in': null,
        'user': null,
        'message': data['message'] ?? '',
      };
    }
  }

  // Ambil user dari storage (cache)
  Future<UserModel?> getCachedUser() async {
    final userJson = await storage.read(key: 'user_data');
    if (userJson != null) {
      try {
        final map = jsonDecode(userJson);
        return UserModel.fromJson(map);
      } catch (_) {}
    }
    return null;
  }

  // Get token
  Future<String?> getToken() async {
    return await storage.read(key: 'auth_token');
  }

  // Get user profile dari API
  Future<UserModel> getUser() async {
    final token = await getToken();
    final res = await dio.get(
      '$baseUrl/user/profile',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return UserModel.fromJson(res.data);
  }

  // Fetch user dari API dan update cache
  Future<UserModel?> fetchAndCacheUser() async {
    try {
      final user = await getUser();
      await storage.write(key: 'user_data', value: jsonEncode(user.toJson()));
      return user;
    } catch (_) {
      return null;
    }
  }

  // Update user profile
  Future<String> updateUser({required String username}) async {
    final token = await getToken();
    final res = await dio.put(
      '$baseUrl/user/profile',
      data: {'username': username},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return res.data['message'] ?? '';
  }

  // Logout
  Future<String> logout() async {
    final token = await getToken();
    final res = await dio.post(
      '$baseUrl/user/logout',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    await storage.delete(key: 'auth_token');
    await storage.delete(key: 'refresh_token');
    await storage.delete(key: 'expires_in');
    await storage.delete(key: 'user_data'); // hapus user cache juga
    return res.data['message'] ?? '';
  }
}
