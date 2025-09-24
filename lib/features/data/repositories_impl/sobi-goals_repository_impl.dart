import '../../domain/repositories/sobi-goals_repository.dart';
import '../../domain/entities/sobi-goals.dart';
import '../datasources/sobi-goals_datasources.dart';
import '../models/sobi_goals_models.dart';

class SobiGoalsRepositoryImpl implements SobiGoalsRepository {
  final SobiGoalsDatasource datasource;
  SobiGoalsRepositoryImpl(this.datasource);

  @override
  Future<UserGoalEntity?> createGoal({
    required String goalCategory,
    required String targetEndDate,
  }) async {
    final model = await datasource.createGoal(
      goalCategory: goalCategory,
      targetEndDate: targetEndDate,
    );
    return model?.toEntity();
  }

  @override
  Future<List<TodayMissionEntity>> getTodayMission() async {
    final List<TodayMissionModel> result = await datasource.getTodayMission();
    return result.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> completeTask({
    required String userGoalId,
    required String taskId,
    required bool completed,
  }) {
    return datasource.completeTask(
      userGoalId: userGoalId,
      taskId: taskId,
      completed: completed,
    );
  }

  @override
  Future<void> getSummaries({required String userGoalId}) {
    return datasource.getSummaries(userGoalId: userGoalId);
  }

  @override
  Future<String?> getCachedGoalStatus() {
    return datasource.getCachedGoalStatus();
  }

  @override
  Future<UserGoalEntity?> getCachedGoal() async {
    final model = await datasource.getCachedGoal();
    return model?.toEntity();
  }
}
