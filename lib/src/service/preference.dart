import 'package:shared_preferences/shared_preferences.dart';

Future setToken(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("Token", value);
}

Future getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString("Token");
}

Future removeTokenSales() async {
  final SharedPreferences shared = await SharedPreferences.getInstance();
  return shared.remove("authTokenSales");
}

Future removeTokenTeknisi() async {
  final SharedPreferences shared = await SharedPreferences.getInstance();
  return shared.remove("authTokenTeknisi");
}

Future removeUserFormLogin() async {
  final SharedPreferences shared = await SharedPreferences.getInstance();
  shared.remove("NameSales");
  shared.remove("NameTeknisi");
  shared.remove("NomorHP");
}
