import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/annotations.dart';
import 'package:tasky/auth/data/datasource/local_auth_datasource.dart';

@GenerateMocks(
  [
    FirebaseAuth,
    GoogleSignIn,
    FirebaseFirestore,
    LocalAuthDataSource,
    User,
    GoogleSignInAccount,
  ],
)
void main() {}
