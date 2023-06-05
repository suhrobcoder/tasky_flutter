import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky/auth/data/datasource/local_auth_datasource.dart';
import 'package:tasky/auth/data/model/user_model.dart';
import 'package:tasky/auth/domain/entity/user_entity.dart';
import 'package:tasky/auth/domain/repository/auth_repository.dart';
import 'package:tasky/core/error/failures.dart';
import 'package:dartz/dartz.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _firestore;
  final LocalAuthDataSource _localAuthDataSource;

  AuthRepositoryImpl(
    this._auth,
    this._googleSignIn,
    this._firestore,
    this._localAuthDataSource,
  );

  @override
  Either<Failure, bool> checkUserAuthenticated() {
    try {
      return Right(
        _auth.currentUser != null || _googleSignIn.currentUser != null,
      );
    } catch (e) {
      return Left(AuthFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> googleSignIn() async {
    try {
      var user = (await _googleSignIn.signIn())!;
      var userDoc = await _firestore.collection("users").doc(user.id).get();
      late UserModel userModel;
      if (userDoc.exists) {
        userModel = UserModel.fromMap(userDoc.data()!);
      } else {
        userModel = UserModel(
          id: user.id,
          name: user.displayName.toString(),
          email: user.email,
          avatarUrl: user.photoUrl.toString(),
        );
        await _firestore
            .collection("users")
            .doc(userModel.id)
            .set(userModel.toMap());
      }
      await _localAuthDataSource.setUser(userModel.id, userModel.name);
      return Right(userModel);
    } catch (e) {
      return Left(AuthFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> registerUser(
      {required String name,
      required String email,
      required String password}) async {
    try {
      var crediental = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      var user = crediental.user!;
      var userModel = UserModel(
        id: user.uid,
        name: user.displayName.toString(),
        email: user.email.toString(),
        avatarUrl: "",
      );
      await _localAuthDataSource.setUser(userModel.id, userModel.name);
      await _firestore
          .collection("users")
          .doc(userModel.id)
          .set(userModel.toMap());
      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(message: e.message ?? "Error"));
    } catch (e) {
      return Left(AuthFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInUser(
      {required String email, required String password}) async {
    try {
      var crediental = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      var user = crediental.user!;
      var userSnapshot =
          await _firestore.collection("users").doc(user.uid).get();
      var userModel = UserModel.fromMap(userSnapshot.data()!);
      await _localAuthDataSource.setUser(userModel.id, userModel.name);
      return Right(UserEntity(user.uid, "", user.email!, ""));
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(message: e.message ?? "Error"));
    } catch (e) {
      return Left(AuthFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      await _localAuthDataSource.remove();
      return const Right(true);
    } catch (e) {
      return Left(AuthFailure());
    }
  }

  @override
  Future<bool> isFirstTIme() async {
    return await _localAuthDataSource.isFirstTime();
  }

  @override
  Future<Either<Failure, bool>> passwordReset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return const Right(true);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(message: e.message ?? defaultErrorMsg));
    } catch (e) {
      return Left(AuthFailure());
    }
  }
}
