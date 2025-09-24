import '../../repositories/sobi-goals_repository.dart';
import '../../entities/sobi-goals.dart';

class GetTodayMission {
  final SobiGoalsRepository repository;
  GetTodayMission(this.repository);

  Future<List<TodayMissionEntity>> call() async {
    final result = await repository.getTodayMission();
    print('[usecase] getTodayMission result: $result');
    return result;
  }
}
