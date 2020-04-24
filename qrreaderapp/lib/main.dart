import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/pages/home_page.dart';
import 'package:qrreaderapp/src/pages/mapa_page.dart';
 
void main() => runApp(MyApp());
 // mateApp escribimos eso y nos hace la cfg por defecto
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QRREADER',
      initialRoute: 'home',
      routes: {
        'home':  (BuildContext context) => HomePage(),
        'mapa':  (BuildContext context) => MapaPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.deepPurple// cambio el color primarycolor
      ), // cambiar el tema de la aplicacion
    );
  }
}