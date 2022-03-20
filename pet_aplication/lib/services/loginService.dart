import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> login(String usuario, String password) async {
  try {
    final response = await http.post(
        Uri.http('192.168.1.9:18080', '/user/login'),
        headers: {'Content-Type': 'application/json', 'charset': 'utf-8'},
        body: json.encode({"username": usuario, "password": password}));

    if (response.statusCode == 200) {
      final token = response.body;
      if (token == 'No hay') {
        return token;
      } else {
        return token;
      }
    } else {
      return 'No se ha podido conectar al servidor';
    }
  } catch (e) {
    return 'Error en la respuesta';
  }
}
