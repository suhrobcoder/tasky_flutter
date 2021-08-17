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
import 'package:tasky/todo/data/datasource/dao/category_dao.dart';
import 'package:tasky/todo/data/datasource/dao/todo_dao.dart';
import 'package:tasky/todo/data/datasource/db_data_source.dart';
import 'package:tasky/todo/data/datasource/todo_database.dart';
import 'package:tasky/todo/data/repository/todo_repository_impl.dart';
import 'package:tasky/todo/domain/repository/todo_repository.dart';
import 'package:tasky/todo/domain/usecase/add_category.dart';
import 'package:tasky/todo/domain/usecase/add_todo.dart';
import 'package:tasky/todo/domain/usecase/complete_todo.dart';
import 'package:tasky/todo/domain/usecase/delete_todo.dart';
import 'package:tasky/todo/domain/usecase/get_categories.dart';
import 'package:tasky/todo/domain/usecase/get_category.dart';
import 'package:tasky/todo/domain/usecase/get_todos_by_category.dart';
import 'package:tasky/todo/domain/usecase/get_todos_for_today.dart';
import 'package:tasky/todo/presentation/pages/calendar/bloc/calendar_bloc.dart';
import 'package:tasky/todo/presentation/pages/home/bloc/home_bloc.dart';
import 'package:tasky/todo/presentation/pages/home_todo_list/bloc/hometodolist_bloc.dart';

final sl = GetIt.instance;

Future setup() async {
  // Auth
  // Bloc
  sl.registerFactory<SplashBloc>(() => SplashBloc(isFirstTime: sl(), checkAuthenticated: sl()));
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
  sl.registerFactory<AuthRepository>(() => AuthRepositoryImpl(sl(), sl(), sl(), sl()));

  // Data source
  sl.registerFactory<LocalAuthDataSource>(() => LocalAuthDataSourceImpl(sl()));

  // External
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn.standard());
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  var sharedPref = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPref);

  // Todo_Layer
  // Bloc
  sl.registerFactory<HomeBloc>(() => HomeBloc());
  sl.registerFactory<HomeTodoListBloc>(() => HomeTodoListBloc(sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory<CalendarBloc>(() => CalendarBloc(sl(), sl(), sl(), sl()));

  // Use Cases
  sl.registerFactory<AddCategory>(() => AddCategory(sl()));
  sl.registerFactory<AddTodo>(() => AddTodo(sl()));
  sl.registerFactory<CompleteTodo>(() => CompleteTodo(sl()));
  sl.registerFactory<DeleteTodo>(() => DeleteTodo(sl()));
  sl.registerFactory<GetCategories>(() => GetCategories(sl()));
  sl.registerFactory<GetTodosByCategory>(() => GetTodosByCategory(sl()));
  sl.registerFactory<GetTodosForToday>(() => GetTodosForToday(sl()));
  sl.registerFactory<GetCategory>(() => GetCategory(sl()));

  // Repository
  sl.registerFactory<TodoRepository>(() => TodoRepositoryImpl(sl()));

  // Data source
  sl.registerFactory<DbDataSource>(() => DbDataSourceImpl(sl(), sl()));
  sl.registerFactory<CategoryDao>(() => CategoryDao(sl()));
  sl.registerFactory<TodoDao>(() => TodoDao(sl()));
  sl.registerLazySingleton<TodoDatabase>(() => TodoDatabase());
}
