import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/todo/data/datasource/todo_database.dart';

@module
abstract class AppModule {
  @injectable
  QueryExecutor executor() => openDatabaseConnection();

  @preResolve
  @injectable
  Future<SharedPreferences> get sharedPref => SharedPreferences.getInstance();

  @injectable
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @injectable
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  @injectable
  GoogleSignIn get googleSignIn => GoogleSignIn.standard();
}
