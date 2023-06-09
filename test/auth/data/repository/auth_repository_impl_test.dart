import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tasky/auth/data/datasource/local_auth_datasource.dart';
import 'package:tasky/auth/data/model/user_model.dart';
import 'package:tasky/auth/data/repository/auth_repository_impl.dart';
import 'package:tasky/auth/domain/repository/auth_repository.dart';
import 'package:tasky/core/error/failures.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockLocalAuthDataSource extends Mock implements LocalAuthDataSource {}

class MockUserCrediental extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockGoogleSignIn mockGoogleSignIn;
  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late MockLocalAuthDataSource mockLocalAuthDataSource;
  late MockUserCrediental mockUserCrediental;
  late MockUser mockFirebaseUser;
  late MockGoogleSignInAccount mockGoogleSignInAccount;
  late AuthRepository authRepository;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockGoogleSignIn = MockGoogleSignIn();
    fakeFirebaseFirestore = FakeFirebaseFirestore();
    mockLocalAuthDataSource = MockLocalAuthDataSource();
    mockLocalAuthDataSource = MockLocalAuthDataSource();
    authRepository = AuthRepositoryImpl(mockFirebaseAuth, mockGoogleSignIn,
        fakeFirebaseFirestore, mockLocalAuthDataSource);
    mockUserCrediental = MockUserCrediental();
    mockFirebaseUser = MockUser();
    mockGoogleSignInAccount = MockGoogleSignInAccount();
  });

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

  group('googleSignIn', () {
    test("when google sign in fail, googleSignIn returns AuthFailure",
        () async {
      when(() => mockGoogleSignIn.signIn())
          .thenAnswer((invocation) async => null);
      final result = await authRepository.googleSignIn();
      expect(result, Left(AuthFailure()));
      verify(() => mockGoogleSignIn.signIn());
    });

    test('when user doesnt exist in firestore, it adds new user', () async {
      when(() => mockGoogleSignIn.signIn())
          .thenAnswer((invocation) async => mockGoogleSignInAccount);
      when(() => mockGoogleSignInAccount.id).thenReturn("123");
      when(() => mockGoogleSignInAccount.displayName).thenReturn("abc");
      when(() => mockGoogleSignInAccount.email).thenReturn("a@g.c");
      when(() => mockGoogleSignInAccount.photoUrl).thenReturn("img.com");
      when(() => mockLocalAuthDataSource.setUser("123", "abc"))
          .thenAnswer((invocation) => Future.value());
      final result = await authRepository.googleSignIn();
      const user = UserModel(
          id: "123", name: "abc", email: "a@g.c", avatarUrl: "img.com");
      expect(result, const Right(user));
      final doc =
          await fakeFirebaseFirestore.collection("users").doc("123").get();
      expect(UserModel.fromMap(doc.data() ?? {}), user);
    });

    test('when user exists in firestore, returns user from firestore',
        () async {
      when(() => mockGoogleSignIn.signIn())
          .thenAnswer((invocation) async => mockGoogleSignInAccount);
      when(() => mockGoogleSignInAccount.id).thenReturn("123");
      when(() => mockGoogleSignInAccount.displayName).thenReturn("abc");
      when(() => mockGoogleSignInAccount.email).thenReturn("a@g.c");
      when(() => mockGoogleSignInAccount.photoUrl).thenReturn("img.com");
      when(() => mockLocalAuthDataSource.setUser("123", "abc"))
          .thenAnswer((invocation) => Future.value());
      const user = UserModel(
          id: "123", name: "abc", email: "a@g.c", avatarUrl: "img2.com");
      fakeFirebaseFirestore.collection("users").doc("123").set(user.toMap());
      final result = await authRepository.googleSignIn();
      expect(result, const Right(user));
    });
  });

  group('registerUser', () {
    const id = "id";
    const name = "name";
    const email = "email";
    const password = "password";
    const url = "url";

    setUp(() {
      when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .thenAnswer((invocation) => Future.value(mockUserCrediental));
      when(() => mockUserCrediental.user).thenReturn(mockFirebaseUser);
      when(() => mockFirebaseUser.uid).thenReturn(id);
      when(() => mockFirebaseUser.displayName).thenReturn(name);
      when(() => mockFirebaseUser.email).thenReturn(email);
      when(() => mockFirebaseUser.photoURL).thenReturn(url);
    });

    test('when register fail returns failure', () async {
      when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .thenThrow(FirebaseAuthException(code: "123", message: "message"));
      final result = await authRepository.registerUser(
          name: name, email: email, password: password);
      expect(result, Left(AuthFailure(message: "message")));
    });

    test('when register success, writes local and firebase, returns user',
        () async {
      when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .thenAnswer((invocation) => Future.value(mockUserCrediental));
      when(() => mockLocalAuthDataSource.setUser(id, name))
          .thenAnswer((invocation) => Future.value());
      final result = await authRepository.registerUser(
          name: name, email: email, password: password);
      const user = UserModel(id: id, name: name, email: email, avatarUrl: url);
      expect(result, const Right(user));
      verify(() => mockLocalAuthDataSource.setUser(id, name));
      final firestoreData =
          await fakeFirebaseFirestore.collection("users").doc(id).get();
      expect(firestoreData.data(), user.toMap());
    });
  });

  group('signInUser', () {
    const id = "id";
    const name = "name";
    const email = "email";
    const password = "password";
    const url = "url";

    setUp(() {
      when(() => mockUserCrediental.user).thenReturn(mockFirebaseUser);
      when(() => mockFirebaseUser.uid).thenReturn(id);
      when(() => mockFirebaseUser.displayName).thenReturn(name);
      when(() => mockFirebaseUser.email).thenReturn(email);
      when(() => mockFirebaseUser.photoURL).thenReturn(url);
    });

    test('when sign in fails, returns failure', () async {
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .thenThrow(FirebaseAuthException(code: "123", message: "message"));
      final result =
          await authRepository.signInUser(email: email, password: password);
      expect(result, Left(AuthFailure(message: "message")));
    });

    test('when sign in success, returns user', () async {
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .thenAnswer((invocation) => Future.value(mockUserCrediental));
      const user = UserModel(id: id, name: name, email: email, avatarUrl: url);
      await fakeFirebaseFirestore.collection("users").doc(id).set(user.toMap());
      when(() => mockLocalAuthDataSource.setUser(id, name))
          .thenAnswer((invocation) => Future.value());
      final result =
          await authRepository.signInUser(email: email, password: password);
      expect(result, const Right(user));
      verify(() => mockLocalAuthDataSource.setUser(id, name));
    });
  });

  group('signOut', () {
    test('when no error returns Right', () async {
      when(() => mockFirebaseAuth.signOut())
          .thenAnswer((invocation) => Future.value());
      when(() => mockGoogleSignIn.signOut())
          .thenAnswer((invocation) => Future.value());
      when(() => mockLocalAuthDataSource.remove())
          .thenAnswer((invocation) => Future.value());
      final result = await authRepository.signOut();
      expect(result, equals(const Right(true)));
      verify(() => mockFirebaseAuth.signOut());
      verify(() => mockGoogleSignIn.signOut());
      verify(() => mockLocalAuthDataSource.remove());
    });

    test('when exception throw return Left', () async {
      when(() => mockFirebaseAuth.signOut())
          .thenThrow(FirebaseAuthException(code: "123"));
      final result = await authRepository.signOut();
      expect(result, equals(Left(AuthFailure())));
      verify(() => mockFirebaseAuth.signOut());
    });
  });

  test("isFirstTime", () async {
    when(() => mockLocalAuthDataSource.isFirstTime())
        .thenAnswer((invocation) => Future.value(true));
    final result = await authRepository.isFirstTIme();
    expect(result, true);
    verify(() => mockLocalAuthDataSource.isFirstTime());
  });

  group("passwordReset", () {
    test('when sendPasswordResetEmail throws exception, returns failure',
        () async {
      when(() => mockFirebaseAuth.sendPasswordResetEmail(email: "fake@g.c"))
          .thenThrow(FirebaseAuthException(code: "123", message: "message"));
      final result = await authRepository.passwordReset("fake@g.c");
      expect(result, Left(AuthFailure(message: "message")));
    });

    test('when sendPasswordResetEmail success, returns Right(true)', () async {
      when(() => mockFirebaseAuth.sendPasswordResetEmail(email: "fake@g.c"))
          .thenAnswer((invocation) => Future.value());
      final result = await authRepository.passwordReset("fake@g.c");
      expect(result, const Right(true));
    });
  });
}
