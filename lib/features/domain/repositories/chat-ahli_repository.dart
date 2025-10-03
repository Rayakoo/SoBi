import '../entities/ahli_entity.dart';

abstract class ChatAhliRepository {
  Future<List<AhliEntity>> getAhli();
}
