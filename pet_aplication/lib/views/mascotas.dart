import 'package:flutter/material.dart';
import 'package:pet_aplication/providers/duenios_modelo.dart';
import 'package:pet_aplication/providers/share.dart';
import 'package:pet_aplication/services/loginService.dart';
import 'package:pet_aplication/providers/mascotas_modelo.dart';

class Mascotas extends StatefulWidget {
  const Mascotas({Key? key}) : super(key: key);

  @override
  State<Mascotas> createState() => _MascotasState();
}

class _MascotasState extends State<Mascotas> {
  @override
  TextEditingController _textFieldController = TextEditingController();
  late List<String> lista_Datos = [];
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  int tamLista = 0;
  List lista_datos = [];
  void initState() {
    super.initState();
    local().getToken().then((token) => {
          get_mascotas_all(token!).then((lista) {
            // listaDatos(value.length, value);
            tamLista = lista.length;
            lista_datos = lista;
          }),
        });
    refreshList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Mascotas'),
      ),
      body: 
      tamLista > 0
          ? RefreshIndicator(
              child: listaDatos(tamLista, lista_datos, context),
              onRefresh: refreshList,
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show();
    await Future.delayed(const Duration(seconds: 1));
    setState(
      () {
        local().getToken().then(
              (token) => {
                get_mascotas_all(token!).then(
                  (lista) {
                    tamLista = lista.length;
                    lista_datos = lista;
                  },
                ),
              },
            );
      },
    );
    return null;
  }

  //https://www.kindacode.com/article/flutter-listtile/
  Widget listaDatos(int lenghtLista, List lista, BuildContext context) {
    final List<Map<String, dynamic>> _items = List.generate(
      lenghtLista,
      (index) => {
        "id": index,
        "title": "Nombre: " + lista[index]['nombre'],
        "raza": "Raza: " +
            lista[index]['raza'] +
            " | Fecha de ingreso: " +
            lista[index]['fechaIngreso']
      },
    );
    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (_, index) => Card(
        margin: const EdgeInsets.all(10),
        child: ListTile(
          title: Text(
            _items[index]['title'],
          ),
          subtitle: Text(
            _items[index]['raza'],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  // print('soy lista xd');
                  lista_Datos.add(lista[index]['nombre']);
                  lista_Datos.add(lista[index]['raza']);
                  lista_Datos.add(lista[index]['fechaIngreso']);
                  lista_Datos.add(lista[index]['razon']);

                  // print(lista_Datos);
                  List listaNavigador = [];
                  listaNavigador.add(lista[index]['idDuenio']);
                  listaNavigador.add(lista[index]['idMascota']);
                  print('listas');
                  // print(lista[index]['idMascota']);
                  // print(lista[index]['idDuenio']);
                  print(listaNavigador);
                  
                  local().setMascota(lista_Datos);
                  Navigator.pushReplacementNamed(context, 'edit_mascota',
                      arguments: listaNavigador);
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  // String id_STR = lista_navigator.toString()[1];
                  // int id_casteado = int.parse(lista_navigator.toString()[1]);

                  // ignore: unnecessary_new
                  Usuario user = new Usuario(
                      id: lista[index]['id'],
                      nombre: lista[index]['nombre'],
                      apellidos: lista[index]['apellidos'],
                      edad: lista[index]['edad'],
                      rol: 'Cliente',
                      username: lista[index]['username'],
                      password: lista[index]['password']);

                  local().getToken().then(
                    (token) {
                      deleteMascota(user, token!).then(
                        (value) {
                          print(value);
                          Navigator.pushReplacementNamed(context, 'duenios');
                        },
                      );
                    },
                  );
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}