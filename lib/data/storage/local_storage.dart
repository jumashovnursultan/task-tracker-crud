import 'dart:convert';
import 'dart:ui';

import 'package:adhdo_it_mob/config/theme/theme_type.dart';
import 'package:adhdo_it_mob/data/models/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorage {
  static LocalStorage? _instance;
  static LocalStorage get instance => _instance!;

  static const tokenKey = 'token';
  static const themeTypeKey = 'theme_type';
  static const localeKey = 'locale_type';
  static const roleKey = 'roleKey';

  factory LocalStorage() => instance;

  LocalStorage._();

  static init() async {
    assert(_instance == null);
    _instance = await SharedPrefLocalStorageImpl._().init();
    return _instance!;
  }

  void setInt(String key, int value);
  void setDouble(String key, double value);
  void setBool(String key, bool value);
  void setString(String key, String value);
  void setStringList(String key, List<String> value);
  void setObject(String key, Object? value);

  bool? getBool(String key);
  int? getInt(String key);
  double? getDouble(String key);
  String? getString(String key);
  List<String>? getStringList(String key);
  dynamic getObject(String key);

  void addListener<T>(String key, Function(dynamic value) listener);
  void removeListener(String key);

  set firstRun(bool val) => setBool('first_run', val);
  bool get firstRun => getBool('first_run') ?? true;

  bool get authSkipped => getBool('auth_skipped') ?? false;
  set authSkipped(bool val) => setBool('auth_skipped', val);

  String get quickOrderText => getString('quick_order_text') ?? '';
  set quickOrderText(String val) => setString('quick_order_text', val);

  ThemeType get themeType => ThemeType.values.firstWhere(
    (element) => element.name == getString(themeTypeKey),
    orElse: () => ThemeType.light,
  );
  set themeType(ThemeType type) => setString(themeTypeKey, type.name);

  Locale? get locale {
    final map = getObject(localeKey);
    return map != null
        ? Locale.fromSubtags(
          languageCode: map['language_code'],
          countryCode: map['country_code'],
        )
        : null;
  }

  set locale(Locale? locale) => setObject(
    localeKey,
    locale != null
        ? {
          'language_code': locale.languageCode,
          'country_code': locale.countryCode,
        }
        : null,
  );

  Token? get token {
    final map = getObject(tokenKey);
    return map != null ? Token.fromJson(map) : null;
  }

  set token(Token? token) => setObject(tokenKey, token?.toJson());
}

class SharedPrefLocalStorageImpl extends LocalStorage {
  SharedPreferences? _preferences;
  Map<String, Function(dynamic value)> listeners = {};

  SharedPrefLocalStorageImpl._() : super._();

  Future<SharedPrefLocalStorageImpl> init() async {
    _preferences = await SharedPreferences.getInstance();

    return this;
  }

  @override
  void setInt(String key, int value) {
    _preferences?.setInt(key, value);
    listeners[key]?.call(value);
  }

  @override
  void setDouble(String key, double value) {
    _preferences?.setDouble(key, value);
    listeners[key]?.call(value);
  }

  @override
  void setBool(String key, bool value) {
    _preferences?.setBool(key, value);

    listeners[key]?.call(value);
  }

  @override
  void setString(String key, String value) {
    _preferences?.setString(key, value);
    listeners[key]?.call(value);
  }

  @override
  void setStringList(String key, List<String> value) {
    _preferences?.setStringList(key, value);
    listeners[key]?.call(value);
  }

  @override
  void setObject(String key, Object? value) {
    _preferences?.setString(key, jsonEncode(value));
    listeners[key]?.call(value);
  }

  @override
  bool? getBool(String key) => _preferences?.getBool(key);
  @override
  int? getInt(String key) => _preferences?.getInt(key);
  @override
  double? getDouble(String key) => _preferences?.getDouble(key);
  @override
  String? getString(String key) => _preferences?.getString(key);
  @override
  List<String>? getStringList(String key) => _preferences?.getStringList(key);
  @override
  dynamic getObject(String key) {
    final value = _preferences?.getString(key);
    if (value != null) return jsonDecode(value);
    return null;
  }

  @override
  void addListener<T>(String key, Function(dynamic value) listener) {
    // _preferences?.
    listeners[key] = listener;
  }

  @override
  void removeListener(String key) => listeners.remove(key);
}
