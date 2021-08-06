import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/auth/data/datasource/local_auth_datasource.dart';
import 'package:tasky/auth/data/repository/auth_repository_impl.dart';
import 'package:tasky/auth/domain/repository/auth_repository.dart';
import 'package:tasky/auth/domain/usecase/check_authenticated.dart';
import 'package:tasky/auth/domain/usecase/google_sign_in_user.dart';
import 'package:tasky/auth/domain/usecase/is_first_time.dart';
import 'package:tasky/auth/domain/usecase/password_reset.dart';
import 'package:tasky/auth/domain/usecase/regiser_user.dart';
import 'package:tasky/auth/domain/usecase/sign_in_user.dart';
import 'package:tasky/auth/domain/usecase/sign_out.dart';
import 'package:tasky/auth/domain/usecase/validate_credientals.dart';
import 'package:tasky/auth/presentation/bloc/password_reset/passwordreset_bloc.dart';
import 'package:tasky/auth/presentation/bloc/register/register_bloc.dart';
import 'package:tasky/auth/presentation/bloc/signin/signin_bloc.dart';
import 'package:tasky/auth/presentation/bloc/splash/splash_bloc.dart';

final sl = GetIt.instance;

Future setup() async {
  // Auth
  // Bloc
  sl.registerFactory<SplashBloc>(
      () => SplashBloc(isFirstTime: sl(), checkAuthenticated: sl()));
  sl.registerFactory<SigninBloc>(() => SigninBloc(sl(), sl(), sl()));
  sl.registerFactory<RegisterBloc>(() => RegisterBloc(sl(), sl()));
  sl.registerFactory<PasswordResetBloc>(() => PasswordResetBloc(sl(), sl()));

  // Use Cases
  sl.registerFactory<CheckAuthenticated>(() => CheckAuthenticated(sl()));
  sl.registerFactory<GoogleSignInUser>(() => GoogleSignInUser(sl()));
  sl.registerFactory<IsFirstTime>(() => IsFirstTime(sl()));
  sl.registerFactory<RegisterUser>(() => RegisterUser(sl()));
  sl.registerFactory<SignInUser>(() => SignInUser(sl()));
  sl.registerFactory<SignOut>(() => SignOut(sl<AuthRepository>()));
  sl.registerFactory<ValidateCredientals>(() => ValidateCredientals());
  sl.registerFactory<PasswordReset>(() => PasswordReset(sl()));

  // Repository
  sl.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(sl(), sl(), sl(), sl()));

  // Data source
  sl.registerFactory<LocalAuthDataSource>(() => LocalAuthDataSourceImpl(sl()));

  // External
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn.standard());
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  var sharedPref = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPref);
}
