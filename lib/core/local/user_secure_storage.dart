
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static final _storage = FlutterSecureStorage();

  static const _keyToken = 'token';
  static const _keyScopes = 'scopes';

  static Future setToken(String token) async =>
      await _storage.write(key: _keyToken, value: token);

  static Future<String?> getToken() async =>
      await _storage.read(key: _keyToken);

  static Future<void> deleteToken() async =>
      await _storage.delete(key: _keyToken);

  static Future setScopes(String scopes) async =>
      await _storage.write(key: _keyScopes, value: scopes);

  static Future<String?> getScopes() async =>
      await _storage.read(key: _keyScopes);

  

  // static Future setPets(List<String> pets) async {
  //   final value = json.encode(pets);

  //   await _storage.write(key: _keyPets, value: value);
  // }

  // static Future<List<String>?> getPets() async {
  //   final value = await _storage.read(key: _keyPets);

  //   return value == null ? null : List<String>.from(json.decode(value));
  // }

  // static Future setBirthday(DateTime dateOfBirth) async {
  //   final birthday = dateOfBirth.toIso8601String();

  //   await _storage.write(key: _keyBirthday, value: birthday);
  // }

  // static Future<DateTime?> getBirthday() async {
  //   final birthday = await _storage.read(key: _keyBirthday);

  //   return birthday == null ? null : DateTime.tryParse(birthday);
  // }
}
