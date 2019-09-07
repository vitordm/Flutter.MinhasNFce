import 'package:flutter/material.dart';
import './ui/lista_nfce.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {'/': (context) => ListaNfce(key: key)},
    );
  }
}
