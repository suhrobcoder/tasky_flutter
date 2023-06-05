import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tasky/auth/domain/repository/auth_repository.dart';
import 'package:tasky/auth/domain/usecase/sign_out.dart';
import 'package:tasky/core/error/failures.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late SignOut signOut;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signOut = SignOut(mockAuthRepository);
  });

  test(
    "should return true when signed out",
    () => () async {
      when(() => mockAuthRepository.signOut())
          .thenAnswer((_) => Future.value(const Right(true)));
      final result = await signOut.execute();
      expect(result, const Right(true));
      verify(() => mockAuthRepository.signOut());
    },
  );

  test(
    "should return failure when fail",
    () => () async {
      when(() => mockAuthRepository.signOut())
          .thenAnswer((_) => Future.value(Left(AuthFailure())));
      final result = await signOut.execute();
      expect(result, equals(Left(AuthFailure())));
      verify(() => mockAuthRepository.signOut());
    },
  );
}
