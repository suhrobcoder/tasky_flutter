import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tasky/auth/domain/entity/user_credientals_entity.dart';
import 'package:tasky/core/error/failures.dart';

void main() {
  var validEmail = "suhrobcoder@gmail.com";
  var invalidEmail = "suhrobcoder.com";
  test(
    "invalid email returns failure",
    () {
      var entity = UserCredientalsEntity(
          email: invalidEmail, password: "123456", passwordRepeat: "123456");
      var result = entity.validate();
      expect(
        result,
        equals(Left(CredientalsValidationFailure(invalidEmailMsg, null))),
      );
    },
  );

  test("don't repeated password returns failure", () {
    var entity = UserCredientalsEntity(
        email: validEmail, password: "123456", passwordRepeat: "1234567");
    var result = entity.validate();
    expect(
      result,
      equals(Left(CredientalsValidationFailure(null, didntMatchPswdMsg))),
    );
  });

  test("weak password returns failure", () {
    var entity = UserCredientalsEntity(
        email: validEmail, password: "12345", passwordRepeat: "12345");
    var result = entity.validate();
    expect(
      result,
      equals(Left(CredientalsValidationFailure(null, weakPswdMsg))),
    );
  });

  test(
    "valid credientals returns true",
    () {
      var entity = UserCredientalsEntity(
          email: validEmail, password: "123456", passwordRepeat: "123456");
      var result = entity.validate();
      expect(
        result,
        equals(Right(true)),
      );
    },
  );
}
