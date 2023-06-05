import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tasky/auth/data/datasource/local_auth_datasource.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late LocalAuthDataSource localAuthDataSource;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localAuthDataSource = LocalAuthDataSourceImpl(mockSharedPreferences);
  });

  test("getUserId returns userId", () {
    when(() => mockSharedPreferences.getString(userIdKey))
        .thenAnswer((_) => "mockUserId");
    var result = localAuthDataSource.getUserId();
    expect(result, "mockUserId");
  });

  test("getUserName returns userName", () {
    when(() => mockSharedPreferences.getString(userNameKey))
        .thenAnswer((_) => "mockUserName");
    var result = localAuthDataSource.getUserName();
    expect(result, "mockUserName");
  });
}
