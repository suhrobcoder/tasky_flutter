import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tasky/auth/data/datasource/local_auth_datasource.dart';
import 'package:tasky/auth/data/repository/auth_repository_impl.dart';
import 'package:tasky/auth/domain/repository/auth_repository.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockLocalAuthDataSource extends Mock implements LocalAuthDataSource {}

class MockUser extends Mock implements User {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockGoogleSignIn mockGoogleSignIn;
  late MockFirebaseFirestore mockFirebaseFirestore;
  late MockLocalAuthDataSource mockLocalAuthDataSource;
  late AuthRepository authRepository;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockGoogleSignIn = MockGoogleSignIn();
    mockFirebaseFirestore = MockFirebaseFirestore();
    mockLocalAuthDataSource = MockLocalAuthDataSource();
    mockLocalAuthDataSource = MockLocalAuthDataSource();
    authRepository = AuthRepositoryImpl(mockFirebaseAuth, mockGoogleSignIn,
        mockFirebaseFirestore, mockLocalAuthDataSource);
  });

  var mockFirebaseUser = MockUser();
  var mockGoogleSignInAccount = MockGoogleSignInAccount();

  group("checkUserAuthenticated", () {
    test("Email and password authenticated returns true", () {
      when(() => mockFirebaseAuth.currentUser)
          .thenAnswer((_) => mockFirebaseUser);
      when(() => mockGoogleSignIn.currentUser).thenAnswer((_) => null);
      var result = authRepository.checkUserAuthenticated();
      expect(result, const Right(true));
    });

    test("Google authenticated returns true", () {
      when(() => mockFirebaseAuth.currentUser).thenAnswer((_) => null);
      when(() => mockGoogleSignIn.currentUser)
          .thenAnswer((_) => mockGoogleSignInAccount);
      var result = authRepository.checkUserAuthenticated();
      expect(result, const Right(true));
    });

    test("Not authenticated returns false", () {
      when(() => mockFirebaseAuth.currentUser).thenAnswer((_) => null);
      when(() => mockGoogleSignIn.currentUser).thenAnswer((_) => null);
      var result = authRepository.checkUserAuthenticated();
      expect(result, const Right(false));
    });
  });
}
