import 'package:flutter/material.dart';
import 'package:flutter_minhas_nfce/src/utils/route_generator.dart';
import 'package:inject/inject.dart';

class App extends StatelessWidget {
  @provide
  App() : super();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
