import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> login(String usuario, String password) async {
  try {
    final response = await http.post(
        Uri.http('192.168.0.8:18080', '/user/login'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode({"username": usuario, "password": password}));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data == null) {
        return [];
      } else {
        return data;
      }
    } else {
      return ['No se ha podido conectar al servidor'];
    }
  } catch (e) {
    return ['Error en la respuesta'];
  }
}
