import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tasky/auth/domain/usecase/check_authenticated.dart';

import 'mock_generator.mocks.dart';

void main() {
  late CheckAuthenticated checkAuthenticated;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    checkAuthenticated = CheckAuthenticated(mockAuthRepository);
  });

  test(
    "should return true if user authenticated",
    () {
      when(mockAuthRepository.checkUserAuthenticated())
          .thenAnswer((_) => const Right(true));
      final result = checkAuthenticated.execute();
      expect(result, const Right(true));
      verify(mockAuthRepository.checkUserAuthenticated());
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );

  test(
    "should return false if user not authenticated",
    () {
      when(mockAuthRepository.checkUserAuthenticated())
          .thenAnswer((_) => const Right(false));
      final result = checkAuthenticated.execute();
      expect(result, const Right(false));
      verify(mockAuthRepository.checkUserAuthenticated());
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
