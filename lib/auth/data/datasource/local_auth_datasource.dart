import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalAuthDataSource {
  String getUserName();
  String getUserId();
  Future setUser(String id, String name);
  Future remove();
}

const userNameKey = "user_name";
const userIdKey = "user_id";

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
  Future setUser(String id, String name) async {
    await _sharedPreferences.setString(userIdKey, id);
    await _sharedPreferences.setString(userNameKey, name);
  }

  @override
  Future remove() async {
    await _sharedPreferences.clear();
  }
}
