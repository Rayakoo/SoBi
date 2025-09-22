import '../../repositories/user_repository.dart';

class UpdateUser {
  final UserRepository repository;
  UpdateUser(this.repository);

  Future<String> call({required String username}) {
    return repository.updateUser(username: username);
  }
}
