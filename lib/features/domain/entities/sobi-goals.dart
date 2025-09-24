class UserGoalEntity {
  final String id;
  final String userId;
  final String goalCategory;
  final String status;
  final int currentDay;
  final DateTime startDate;
  final DateTime targetEndDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserGoalEntity({
    required this.id,
    required this.userId,
    required this.goalCategory,
    required this.status,
    required this.currentDay,
    required this.startDate,
    required this.targetEndDate,
    required this.createdAt,
    required this.updatedAt,
  });
}

class MissionEntity {
  final String id;
  final int dayNumber;
  final String focus;
  final String category;

  MissionEntity({
    required this.id,
    required this.dayNumber,
    required this.focus,
    required this.category,
  });
}

class TaskEntity {
  final String id;
  final String missionId;
  final String text;

  TaskEntity({required this.id, required this.missionId, required this.text});
}

class ProgressEntity {
  final String id;
  final String userGoalId;
  final String? missionId;
  final String? taskId;
  final String userId;
  final bool isCompleted;
  final DateTime? completedAt;
  final int? totalTasks;
  final int? completedTasks;
  final double? completionPercentage;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProgressEntity({
    required this.id,
    required this.userGoalId,
    this.missionId,
    this.taskId,
    required this.userId,
    required this.isCompleted,
    this.completedAt,
    this.totalTasks,
    this.completedTasks,
    this.completionPercentage,
    this.createdAt,
    this.updatedAt,
  });
}

class TaskWithProgressEntity {
  final TaskEntity task;
  final ProgressEntity progress;

  TaskWithProgressEntity({required this.task, required this.progress});
}

class MissionWithTasksEntity {
  final MissionEntity mission;
  final List<TaskWithProgressEntity> tasks;
  final ProgressEntity progress;

  MissionWithTasksEntity({
    required this.mission,
    required this.tasks,
    required this.progress,
  });
}

class TodayMissionEntity {
  final UserGoalEntity userGoal;
  final int dayIndex;
  final List<MissionWithTasksEntity> missions;

  TodayMissionEntity({
    required this.userGoal,
    required this.dayIndex,
    required this.missions,
  });
}
