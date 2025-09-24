import 'package:flutter/material.dart';
import '../../domain/entities/sobi-goals.dart';
import '../../domain/usecases/sobi-goals/create_goals.dart';
import '../../domain/usecases/sobi-goals/get_mission.dart';
import '../../domain/usecases/sobi-goals/post_task_user.dart';
import '../../domain/usecases/sobi-goals/get_summaries.dart';
import '../../data/datasources/sobi-goals_datasources.dart';

class SobiGoalsProvider extends ChangeNotifier {
  final CreateGoals createGoalsUsecase;
  final GetTodayMission getTodayMissionUsecase;
  final CompleteTask completeTaskUsecase;
  final GetSummaries getSummariesUsecase;
  final SobiGoalsDatasource datasource;

  List<TodayMissionEntity> todayMissions = [];
  String? goalStatus;
  UserGoalEntity? goalEntity;
  bool isLoading = false;
  String? error;

  SobiGoalsProvider({
    required this.createGoalsUsecase,
    required this.getTodayMissionUsecase,
    required this.completeTaskUsecase,
    required this.getSummariesUsecase,
    required this.datasource,
  });

  Future<void> createGoal(String goalCategory, String targetEndDate) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      final goal = await createGoalsUsecase(
        goalCategory: goalCategory,
        targetEndDate: targetEndDate,
      );
      goalEntity = goal;
      goalStatus = goal?.status;
      await fetchTodayMission();
      error = null;
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchGoalStatusAndMission() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      goalStatus =
          await getTodayMissionUsecase.repository.getCachedGoalStatus();
      goalEntity = await getTodayMissionUsecase.repository.getCachedGoal();
      await fetchTodayMission();
      error = null;
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchTodayMission() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      todayMissions = await getTodayMissionUsecase();
      print('[provider] fetchTodayMission todayMissions: $todayMissions');
      if (todayMissions.isNotEmpty) {
        final active = todayMissions.firstWhere(
          (m) => m.userGoal.status != null,
          orElse: () => todayMissions.first,
        );
        goalStatus = active.userGoal.status;
        print('[provider] fetchTodayMission goalStatus: $goalStatus');
        if (goalStatus == 'active') {
          await datasource.storage.write(key: 'goal_status', value: 'active');
        }
      }
      error = null;
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> completeTask(String userGoalId, String taskId) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      await completeTaskUsecase(
        userGoalId: userGoalId,
        taskId: taskId,
        completed: true,
      );
      await fetchTodayMission(); // reload mission after complete
      error = null;
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> getSummaries(String userGoalId) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      await getSummariesUsecase(userGoalId: userGoalId);
      error = null;
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
