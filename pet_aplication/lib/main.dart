import 'package:flutter/material.dart';
import 'package:pet_aplication/views/home.dart';
import 'package:pet_aplication/views/login.dart';
import 'package:provider/provider.dart';

import 'providers/loginProvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginProvider(),
          lazy: false,
        )
      ],
      child: MaterialApp(
        title: 'Vet-App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: 'login',
        routes: {
          'login': (_) => const Login(),
          'home': (_) => Home(),
        },
      ),
    );
  }
}
