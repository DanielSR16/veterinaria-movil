import 'package:flutter/material.dart';
import 'package:pet_aplication/providers/duenios_modelo.dart';
import 'package:pet_aplication/providers/mascotas_modelo.dart';
import 'package:pet_aplication/providers/share.dart';
import 'package:pet_aplication/views/mascotas.dart';
import 'package:pet_aplication/services/loginService.dart';

class edit_mascota extends StatefulWidget {
  // final Usuario user;
  // const edit_duenio({Key? key, required, required this.user}) : super(key: key);
  const edit_mascota({
    Key? key,
    required,
  }) : super(key: key);
  @override
  State<edit_mascota> createState() => _edit_mascotaState(
      // user: user
      );
}

class _edit_mascotaState extends State<edit_mascota> {
  // final Usuario user;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  // _edit_duenioState({required this.user});
  late var nombre = TextEditingController();
  late var raza = TextEditingController();
  late var fechaIngreso = TextEditingController();
  late var razon = TextEditingController();
  late List<String> datos_mascota = [];
  late var iniciar = false;
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    nombre.dispose();
    raza.dispose();
    fechaIngreso.dispose();
    razon.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    //CHECAR DESPUES EL GET DUEÑO

    //CAMBIAR EL GETDUEÑO
    local().getMascota().then((lista) {
      print(lista);
      datos_mascota = lista!;
    });
    refreshList();
  }

  @override
  Widget build(BuildContext context) {
    double width_total = MediaQuery.of(context).size.width;
    double height_total = MediaQuery.of(context).size.height;
    final Object? lista_navigator = ModalRoute.of(context)!.settings.arguments;
    iniciar = true;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Modificar Mascota'),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'mascotas');
          },
        ),
      ),
      body: iniciar == true
          ? RefreshIndicator(
              child: ListView(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                children: [
                  input(width_total, height_total, 'Nombre', nombre),
                  input(width_total, height_total, 'Raza', raza),
                  input(width_total, height_total, 'Fecha de ingreso',
                      fechaIngreso),
                  input(width_total, height_total, 'Razon de ingreso', razon),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    // width: 300,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        List? lista = [];
                        lista = lista_navigator as List?;
                        int id_mascota = lista![1];
                        int id_duenio = lista[0];

                        // int idCasteado = int.parse(lista![1]);

                        // int idCasteadoMascota = int.parse(lista![0]);

                        Mascota mascotau = Mascota(
                          idDuenio: id_duenio,
                          idMascota: id_mascota,
                          nombre: nombre.text,
                          raza: raza.text,
                          fechaIngreso: fechaIngreso.text,
                          razon: razon.text,
                        );

                        local().getToken().then(
                          (token) {
                            //CAMBIAR EL UPDATE
                            updateMascota(mascotau, token!).then(
                              (value) {
                                print(value);
                                Navigator.pushReplacementNamed(
                                    context, 'mascotas');
                              },
                            );
                          },
                        );
                      },
                      child: const Text('Editar Usuario'),
                    ),
                  ),
                ],
              ),
              onRefresh: refreshList)
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget input(width_total, height_total, nombre_input,
      TextEditingController controlador) {
    return Container(
      width: width_total * 0.8,
      height: height_total * 0.1,
      margin: const EdgeInsets.only(top: 1),
      child: TextField(
        controller: controlador,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          hintText: nombre_input,
        ),
      ),
    );
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show();
    await Future.delayed(const Duration(milliseconds: 30));
    setState(
      () {
        //CAMBIAR EL GET DUEÑO
        local().getMascota().then((lista) {
          print(lista);
          nombre = new TextEditingController(text: lista![0]);
          raza = new TextEditingController(text: lista[1]);
          fechaIngreso = new TextEditingController(text: lista[2]);
          razon = new TextEditingController(text: lista[3]);
        });
      },
    );
    return null;
  }
}
