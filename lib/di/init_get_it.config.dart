// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i6;
import 'package:drift/drift.dart' as _i9;
import 'package:firebase_auth/firebase_auth.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i10;
import 'package:tasky/auth/data/datasource/local_auth_datasource.dart' as _i25;
import 'package:tasky/auth/data/repository/auth_repository_impl.dart' as _i28;
import 'package:tasky/auth/domain/repository/auth_repository.dart' as _i27;
import 'package:tasky/auth/domain/usecase/check_authenticated.dart' as _i30;
import 'package:tasky/auth/domain/usecase/google_sign_in_user.dart' as _i31;
import 'package:tasky/auth/domain/usecase/is_first_time.dart' as _i32;
import 'package:tasky/auth/domain/usecase/password_reset.dart' as _i33;
import 'package:tasky/auth/domain/usecase/regiser_user.dart' as _i35;
import 'package:tasky/auth/domain/usecase/sign_in_user.dart' as _i36;
import 'package:tasky/auth/domain/usecase/sign_out.dart' as _i37;
import 'package:tasky/auth/domain/usecase/validate_credientals.dart' as _i15;
import 'package:tasky/auth/presentation/bloc/password_reset/passwordreset_bloc.dart'
    as _i34;
import 'package:tasky/auth/presentation/bloc/register/register_bloc.dart'
    as _i40;
import 'package:tasky/auth/presentation/bloc/signin/signin_bloc.dart' as _i38;
import 'package:tasky/auth/presentation/bloc/splash/splash_bloc.dart' as _i39;
import 'package:tasky/di/app_module.dart' as _i41;
import 'package:tasky/todo/data/datasource/dao/category_dao.dart' as _i3;
import 'package:tasky/todo/data/datasource/dao/todo_dao.dart' as _i11;
import 'package:tasky/todo/data/datasource/db_data_source.dart' as _i14;
import 'package:tasky/todo/data/datasource/todo_database.dart' as _i4;
import 'package:tasky/todo/data/repository/todo_repository_impl.dart' as _i13;
import 'package:tasky/todo/domain/repository/todo_repository.dart' as _i12;
import 'package:tasky/todo/domain/usecase/add_category.dart' as _i16;
import 'package:tasky/todo/domain/usecase/add_todo.dart' as _i17;
import 'package:tasky/todo/domain/usecase/complete_todo.dart' as _i18;
import 'package:tasky/todo/domain/usecase/delete_todo.dart' as _i19;
import 'package:tasky/todo/domain/usecase/get_categories.dart' as _i20;
import 'package:tasky/todo/domain/usecase/get_category.dart' as _i21;
import 'package:tasky/todo/domain/usecase/get_todos_by_category.dart' as _i22;
import 'package:tasky/todo/domain/usecase/get_todos_for_today.dart' as _i23;
import 'package:tasky/todo/presentation/pages/add_todo/bloc/add_todo_bloc.dart'
    as _i26;
import 'package:tasky/todo/presentation/pages/calendar/bloc/calendar_bloc.dart'
    as _i29;
import 'package:tasky/todo/presentation/pages/home/bloc/home_bloc.dart' as _i8;
import 'package:tasky/todo/presentation/pages/home_todo_list/bloc/hometodolist_bloc.dart'
    as _i24;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.factory<_i3.CategoryDao>(() => _i3.CategoryDao(gh<_i4.TodoDatabase>()));
    gh.factory<_i5.FirebaseAuth>(() => appModule.firebaseAuth);
    gh.factory<_i6.FirebaseFirestore>(() => appModule.firestore);
    gh.factory<_i7.GoogleSignIn>(() => appModule.googleSignIn);
    gh.factory<_i8.HomeBloc>(() => _i8.HomeBloc());
    gh.factory<_i9.QueryExecutor>(() => appModule.executor());
    await gh.factoryAsync<_i10.SharedPreferences>(
      () => appModule.sharedPref,
      preResolve: true,
    );
    gh.factory<_i11.TodoDao>(() => _i11.TodoDao(gh<_i4.TodoDatabase>()));
    gh.factory<_i12.TodoRepository>(
        () => _i13.TodoRepositoryImpl(gh<_i14.DbDataSource>()));
    gh.factory<_i15.ValidateCredientals>(() => _i15.ValidateCredientals());
    gh.factory<_i16.AddCategory>(
        () => _i16.AddCategory(gh<_i12.TodoRepository>()));
    gh.factory<_i17.AddTodo>(() => _i17.AddTodo(gh<_i12.TodoRepository>()));
    gh.factory<_i18.CompleteTodo>(
        () => _i18.CompleteTodo(gh<_i12.TodoRepository>()));
    gh.factory<_i19.DeleteTodo>(
        () => _i19.DeleteTodo(gh<_i12.TodoRepository>()));
    gh.factory<_i20.GetCategories>(
        () => _i20.GetCategories(gh<_i12.TodoRepository>()));
    gh.factory<_i21.GetCategory>(
        () => _i21.GetCategory(gh<_i12.TodoRepository>()));
    gh.factory<_i22.GetTodosByCategory>(
        () => _i22.GetTodosByCategory(gh<_i12.TodoRepository>()));
    gh.factory<_i23.GetTodosForToday>(
        () => _i23.GetTodosForToday(gh<_i12.TodoRepository>()));
    gh.factory<_i24.HomeTodoListBloc>(() => _i24.HomeTodoListBloc(
          gh<_i20.GetCategories>(),
          gh<_i23.GetTodosForToday>(),
          gh<_i16.AddCategory>(),
          gh<_i19.DeleteTodo>(),
          gh<_i18.CompleteTodo>(),
        ));
    gh.factory<_i25.LocalAuthDataSource>(
        () => _i25.LocalAuthDataSourceImpl(gh<_i10.SharedPreferences>()));
    gh.factory<_i26.AddTodoBloc>(() => _i26.AddTodoBloc(
          gh<_i20.GetCategories>(),
          gh<_i17.AddTodo>(),
        ));
    gh.factory<_i27.AuthRepository>(() => _i28.AuthRepositoryImpl(
          gh<_i5.FirebaseAuth>(),
          gh<_i7.GoogleSignIn>(),
          gh<_i6.FirebaseFirestore>(),
          gh<_i25.LocalAuthDataSource>(),
        ));
    gh.factory<_i29.CalendarBloc>(() => _i29.CalendarBloc(
          gh<_i22.GetTodosByCategory>(),
          gh<_i21.GetCategory>(),
          gh<_i19.DeleteTodo>(),
          gh<_i18.CompleteTodo>(),
        ));
    gh.factory<_i30.CheckAuthenticated>(
        () => _i30.CheckAuthenticated(gh<_i27.AuthRepository>()));
    gh.factory<_i31.GoogleSignInUser>(
        () => _i31.GoogleSignInUser(gh<_i27.AuthRepository>()));
    gh.factory<_i32.IsFirstTime>(
        () => _i32.IsFirstTime(gh<_i27.AuthRepository>()));
    gh.factory<_i33.PasswordReset>(
        () => _i33.PasswordReset(gh<_i27.AuthRepository>()));
    gh.factory<_i34.PasswordResetBloc>(() => _i34.PasswordResetBloc(
          gh<_i15.ValidateCredientals>(),
          gh<_i33.PasswordReset>(),
        ));
    gh.factory<_i35.RegisterUser>(
        () => _i35.RegisterUser(gh<_i27.AuthRepository>()));
    gh.factory<_i36.SignInUser>(
        () => _i36.SignInUser(gh<_i27.AuthRepository>()));
    gh.factory<_i37.SignOut>(() => _i37.SignOut(gh<_i27.AuthRepository>()));
    gh.factory<_i38.SigninBloc>(() => _i38.SigninBloc(
          gh<_i15.ValidateCredientals>(),
          gh<_i36.SignInUser>(),
          gh<_i31.GoogleSignInUser>(),
        ));
    gh.factory<_i39.SplashBloc>(() => _i39.SplashBloc(
          isFirstTime: gh<_i32.IsFirstTime>(),
          checkAuthenticated: gh<_i30.CheckAuthenticated>(),
        ));
    gh.factory<_i40.RegisterBloc>(() => _i40.RegisterBloc(
          gh<_i35.RegisterUser>(),
          gh<_i15.ValidateCredientals>(),
        ));
    return this;
  }
}

class _$AppModule extends _i41.AppModule {}
