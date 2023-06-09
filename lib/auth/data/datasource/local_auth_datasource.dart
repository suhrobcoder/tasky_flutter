import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalAuthDataSource {
  String getUserName();
  String getUserId();
  Future<void> setUser(String id, String name);
  Future<bool> isFirstTime();
  Future<void> remove();
}

const userNameKey = "user_name";
const userIdKey = "user_id";
const firstTimeKey = "first_time";

@Injectable(as: LocalAuthDataSource)
class LocalAuthDataSourceImpl implements LocalAuthDataSource {
  final SharedPreferences _sharedPreferences;

  LocalAuthDataSourceImpl(this._sharedPreferences);

  @override
  String getUserId() {
    return _sharedPreferences.getString(userIdKey).toString();
  }

  @override
  String getUserName() {
    return _sharedPreferences.getString(userNameKey).toString();
  }

  @override
  Future<void> setUser(String id, String name) async {
    await _sharedPreferences.setString(userIdKey, id);
    await _sharedPreferences.setString(userNameKey, name);
  }

  @override
  Future<bool> isFirstTime() async {
    var res = _sharedPreferences.getBool(firstTimeKey) ?? true;
    await _sharedPreferences.setBool(firstTimeKey, false);
    return res;
  }

  @override
  Future<void> remove() async {
    await _sharedPreferences.remove(userIdKey);
    await _sharedPreferences.remove(userNameKey);
  }
}
