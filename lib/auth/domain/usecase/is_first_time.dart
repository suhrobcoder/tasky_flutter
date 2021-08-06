import 'package:tasky/auth/domain/repository/auth_repository.dart';

class IsFirstTime {
  final AuthRepository authRepository;

  IsFirstTime(this.authRepository);

  Future<bool> execute() async {
    return await authRepository.isFirstTIme();
  }
}
