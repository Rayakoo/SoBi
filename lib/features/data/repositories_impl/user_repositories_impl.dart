import '../../domain/repositories/user_repository.dart';
import '../datasources/auth_datasources.dart';

class UserRepositoryImpl implements UserRepository {
  final AuthDatasources datasource;
  UserRepositoryImpl(this.datasource);

  @override
  Future<String> updateUser({required String username}) {
    return datasource.updateUser(username: username);
  }
}
