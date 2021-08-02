import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tasky/auth/domain/entity/user_entity.dart';
import 'package:tasky/auth/domain/repository/auth_repository.dart';
import 'package:tasky/auth/domain/usecase/google_sign_in_user.dart';
import 'package:tasky/core/error/failures.dart';

import 'mock_generator.mocks.dart';

void main() {
  late AuthRepository mockAuthRepository;
  late GoogleSignInUser googleSignInUser;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    googleSignInUser = GoogleSignInUser(mockAuthRepository);
  });

  const mockUser = UserEntity("mockId", "mockName", "mockEmail", "mockUrl");

  test(
    "should return user when succesfully sign in",
    () async {
      when(mockAuthRepository.googleSignIn())
          .thenAnswer((_) => Future.value(const Right(mockUser)));
      final result = await googleSignInUser.execute();
      expect(result, equals(Right(mockUser)));
      verify(mockAuthRepository.googleSignIn());
    },
  );

  test(
    "should return failure when fail",
    () async {
      when(mockAuthRepository.googleSignIn())
          .thenAnswer((_) => Future.value(Left(AuthFailure())));
      final result = await googleSignInUser.execute();
      expect(result, equals(Left(AuthFailure())));
      verify(mockAuthRepository.googleSignIn());
    },
  );
}
