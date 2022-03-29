// import 'dart:_http';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:pet_aplication/providers/loginProvider.dart';

Future<List<dynamic>> login(String usuario, String password) async {
  try {
    final response = await http.post(
        Uri.http('192.168.1.71:18080', '/user/login'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode({"username": usuario, "password": password}));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
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

Future<List<dynamic>> get_duenios_all(String token) async {
  var resultado;
  print(LoginProvider().jwt);
  print('object');
  try {
    final response = await http
        .get(Uri.http('192.168.1.71:18080', '/user/listUser'), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader:
          ' Bearer eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJ1c2VySldUIiwic3ViIjoicSIsImF1dGhvcml0aWVzIjpbIlJPTEVfVVNFUiJdLCJpYXQiOjE2NDg1MzQ0NzAsImV4cCI6MTY0ODU0MDQ3MH0.yK7AIHjKHaCDLr9apA1ptA6Y6BhdJoXynznjgi8gPKTYDKpTxrAyDoGdpG8MR4YiIAsobqZWBczlIHydjvLe3g'
    });

    // body: json.encode({"username": usuario, "password": password}));
    resultado = json.decode(response.body);
    // print(resultado);
    return resultado;
  } catch (e) {
    return ['Error en la respuesta'];
  }
}
