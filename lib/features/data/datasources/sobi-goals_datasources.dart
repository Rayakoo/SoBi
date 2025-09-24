import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/sobi_goals_models.dart';

class SobiGoalsDatasource {
  final Dio dio;
  final FlutterSecureStorage storage; // pastikan ini public
  final String baseUrl;

  SobiGoalsDatasource({
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

  Future<String?> _getToken() async {
    return await storage.read(key: 'auth_token');
  }

  Future<UserGoalModel?> createGoal({
    required String goalCategory,
    required String targetEndDate,
  }) async {
    try {
      final token = await _getToken();
      print('[DEBUG getToken] token=$token');
      print(
        '[DEBUG getToken] "goal_category": $goalCategory, "target_end_date": $targetEndDate',
      );
      final res = await dio.post(
        '$baseUrl/goals/create',
        data: {"goal_category": goalCategory, "target_end_date": targetEndDate},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final data = res.data;
      if (data != null && data['goal'] != null) {
        // Simpan status goal ke cache
        await storage.write(key: 'goal_status', value: data['goal']['status']);
        await storage.write(key: 'goal_data', value: jsonEncode(data['goal']));
        return UserGoalModel.fromJson(data['goal']); // return Model
      }
      return null;
    } catch (e, stack) {
      // Bisa diganti dengan log atau throw sesuai kebutuhan
      print('Error saat createGoal: $e');
      print(stack);
      return null;
    }
  }

  Future<String?> getCachedGoalStatus() async {
    return await storage.read(key: 'goal_status');
  }

  Future<UserGoalModel?> getCachedGoal() async {
    final goalJson = await storage.read(key: 'goal_data');
    if (goalJson != null) {
      return UserGoalModel.fromJson(jsonDecode(goalJson)); // return Model
    }
    return null;
  }

  Future<List<TodayMissionModel>> getTodayMission() async {
    final token = await _getToken();
    final res = await dio.get(
      '$baseUrl/goals/today-mission',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    final raw = res.data;
    if (raw is List) {
      return raw.map((e) => TodayMissionModel.fromJson(e)).toList();
    }
    return [];
  }

  Future<void> completeTask({
    required String userGoalId,
    required String taskId,
    required bool completed,
  }) async {
    final token = await _getToken();
    print('[DEBUG completeTask] token=$token');
    print(
      '[DEBUG completeTask] user_goal_id=$userGoalId, task_id=$taskId, completed=$completed',
    );
    await dio.post(
      '$baseUrl/goals/tasks/complete',
      data: {
        "user_goal_id": userGoalId,
        "task_id": taskId,
        "completed": completed,
      },
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  Future<void> getSummaries({required String userGoalId}) async {
    final token = await _getToken();
    // Response kosongkan dulu, return nothing
    await dio.post(
      '$baseUrl/goals/summaries',
      data: {"user_goal_id": userGoalId},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}
