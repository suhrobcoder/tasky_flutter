import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tasky/auth/domain/entity/user_credientals_entity.dart';
import 'package:tasky/auth/domain/entity/user_entity.dart';
import 'package:tasky/auth/domain/repository/auth_repository.dart';
import 'package:tasky/auth/domain/usecase/regiser_user.dart';
import 'package:tasky/auth/domain/usecase/sign_in_user.dart';
import 'package:tasky/core/error/failures.dart';

import 'google_sign_in_user_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late MockAuthRepository mockAuthRepository;
  late SignInUser signInUser;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signInUser = SignInUser(mockAuthRepository);
  });

  var mockUser = const UserEntity("id", "name", "email", "avatarUrl");

  test(
    "invalid credientals returns [CredientalsFailure]",
    () async {
      when(mockAuthRepository.signInUser())
          .thenAnswer((_) => Future.value(Right(mockUser)));
      var result = await signInUser.execute(
          email: "invalidEmail", password: "1234", passwordRepeat: "1234");
      expect(
        result,
        equals(
            Left(CredientalsValidationFailure(invalidEmailMsg, weakPswdMsg))),
      );
      verifyZeroInteractions(mockAuthRepository);
    },
  );
  test(
    "should return AuthFailure when repository returns failure",
    () async {
      when(mockAuthRepository.signInUser(
              email: "suhrobcoder@gmail.com", password: "123456"))
          .thenAnswer((_) => Future.value(Left(AuthFailure())));
      var result = await signInUser.execute(
          email: "suhrobcoder@gmail.com",
          password: "123456",
          passwordRepeat: "123456");
      expect(
        result,
        equals(Left(AuthFailure())),
      );
      verify(mockAuthRepository.signInUser(
          email: "suhrobcoder@gmail.com", password: "123456"));
    },
  );

  test(
    "should return user entity when successful",
    () async {
      when(mockAuthRepository.signInUser(
              email: "suhrobcoder@gmail.com", password: "123456"))
          .thenAnswer((_) => Future.value(Right(mockUser)));
      var result = await signInUser.execute(
          email: "suhrobcoder@gmail.com",
          password: "123456",
          passwordRepeat: "123456");
      expect(
        result,
        equals(Right(mockUser)),
      );
      verify(mockAuthRepository.signInUser(
          email: "suhrobcoder@gmail.com", password: "123456"));
    },
  );
}
