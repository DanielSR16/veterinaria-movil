import 'package:flutter/material.dart';

class empleadoView extends StatefulWidget {
  const empleadoView({Key? key}) : super(key: key);

  @override
  State<empleadoView> createState() => _empleadoViewState();
}

class _empleadoViewState extends State<empleadoView> {
  @override
  Widget build(BuildContext context) {
    final Object? name = ModalRoute.of(context)!.settings.arguments;
    String na = name.toString();
    String ti = 'Bienvenido ' + na;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(ti),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 50),
        child: ListView(children: [
          Center(
            child: Container(
              padding: EdgeInsets.only(top: 10),
              width: 250,
              height: 70,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.lightGreen,
                    padding:
                        EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    'citas',
                  );
                },
                child: Text('Citas', style: TextStyle(fontSize: 20)),
              ),
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.only(top: 30),
              width: 250,
              height: 90,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.lightGreen,
                    padding:
                        EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    'duenios',
                  );
                },
                child: Text('Dueños', style: TextStyle(fontSize: 20)),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 250),
            child: Center(
              child: Container(
                padding: EdgeInsets.only(top: 30),
                width: 250,
                height: 90,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.redAccent,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      'login',
                    );
                  },
                  child: Text('Cerrar Sesion', style: TextStyle(fontSize: 20)),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
