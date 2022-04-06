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
    local().getToken().then(
          (token) => {
            local().getIdDuenio().then((id) {
              get_mascotas_id(token!, id).then(
                (lista) {
                  tamLista = lista.length;
                  lista_datos = lista;
                },
              );
            })
          },
        );
    refreshList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Mascotas'),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pushReplacementNamed(
              context,
              'login',
            );
          },
        ),
      ),
      body: tamLista > 0
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
                local().getIdDuenio().then((id) {
                  get_mascotas_id(token!, id).then(
                    (lista) {
                      tamLista = lista.length;
                      lista_datos = lista;
                    },
                  );
                })
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
                  lista_Datos.add(lista[index]['nombre']);
                  lista_Datos.add(lista[index]['raza']);
                  lista_Datos.add(lista[index]['fechaIngreso']);
                  lista_Datos.add(lista[index]['razon']);

                  List listaNavigador = [];
                  listaNavigador.add(lista[index]['idDuenio']);
                  listaNavigador.add(lista[index]['idMascota']);

                  local().setMascota(lista_Datos);
                  Navigator.pushReplacementNamed(context, 'edit_mascota',
                      arguments: listaNavigador);
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  Mascota mascotau = Mascota(
                    idDuenio: lista[index]['idDuenio'],
                    idMascota: lista[index]['idMascota'],
                    nombre: lista[index]['nombre'],
                    raza: lista[index]['raza'],
                    fechaIngreso: lista[index]['fechaIngreso'],
                    razon: lista[index]['razon'],
                  );

                  local().getToken().then(
                    (token) {
                      deleteMascota(mascotau, token!).then(
                        (value) {
                          print(value);
                          Navigator.pushReplacementNamed(context, 'mascotas');
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
