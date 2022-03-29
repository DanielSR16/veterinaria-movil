import 'package:flutter/material.dart';
import 'package:pet_aplication/providers/share.dart';
import 'package:pet_aplication/services/loginService.dart';

class duenios extends StatefulWidget {
  const duenios({Key? key}) : super(key: key);

  @override
  State<duenios> createState() => _dueniosState();
}

class _dueniosState extends State<duenios> {
  @override
  TextEditingController _textFieldController = TextEditingController();
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  int tamLista = 0;
  List lista_datos = [];
  void initState() {
    super.initState();
    local().getToken().then((token) => {
          get_duenios_all(token!).then((lista) {
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
        title: const Text('Dueños'),
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
    await Future.delayed(const Duration(seconds: 3));
    setState(
      () {
        local().getToken().then(
              (token) => {
                get_duenios_all(token!).then(
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

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Container(
          height: 100,
          child: AlertDialog(
            title: Text('TextField in Dialog'),
            content: Column(

              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {},
                  controller: _textFieldController,
                  decoration: InputDecoration(hintText: "Text Field in Dialog"),
                ),
                TextField(
                  onChanged: (value) {},
                  controller: _textFieldController,
                  decoration: InputDecoration(hintText: "Text Field in Dialog"),
                ),
                TextField(
                  onChanged: (value) {},
                  controller: _textFieldController,
                  decoration: InputDecoration(hintText: "Text Field in Dialog"),
                ),
               
              ],
            ),
            actions: <Widget>[
              TextButton(
                //  color: Colors.green,
                //  textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    //  codeDialog = valueText;
                    Navigator.pop(context);
                  });
                },
              )
            ],
          ),
        );
      },
    );
  }

  //https://www.kindacode.com/article/flutter-listtile/
  Widget listaDatos(int lenghtLista, List lista, BuildContext context) {
    final List<Map<String, dynamic>> _items = List.generate(
      lenghtLista,
      (index) => {
        "id": index,
        "title": "Usuario: " + lista[index]['username'],
        "subtitle": "Nombre: " +
            lista[index]['nombre'] +
            " | Apellido: " +
            lista[index]['apellidos']
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
            _items[index]['subtitle'],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  _displayTextInputDialog(context);
                },
                icon: const Icon(Icons.edit),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
