import 'Prefs.dart';

class PrefHelper {
  static void setToken(data) async {
    await Prefs.set('token', data);
  }

  static Future<String> getToken() async {
    return await Prefs.get('token');
  }

  static void setMobile(data) async {
    await Prefs.set('mobile', data);
  }

  static Future<String> getMobile() async {
    return await Prefs.get('mobile');
  }

}
