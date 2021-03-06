import 'package:shared_preferences/shared_preferences.dart';

class local {
  Future<Future<bool>> setToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('jwt', token);
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt');
  }

  Future<Future<bool>> setDuenio(List<String> lista) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList('listaDuenio', lista);
  }

  Future<List<String>?> getDuenio() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('listaDuenio');
  }

  Future<Future<bool>> setMascota(List<String> lista) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList('listaMascota', lista);
  }

  Future<List<String>?> getMascota() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('listaMascota');
  }

  Future<Future<bool>> setCitas(List<String> lista) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList('listaCitas', lista);
  }

  Future<List<String>?> getCitas() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('listaCitas');
  }

  Future<Future<bool>> setIdDuenio(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt('idDuenio', id);
  }

  Future getIdDuenio() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('idDuenio');
  }
}
