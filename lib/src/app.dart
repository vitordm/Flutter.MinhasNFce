import 'package:flutter/material.dart';
import 'package:flutter_minhas_nfce/src/blocs/lista_nfce_bloc.dart';
import 'package:flutter_minhas_nfce/src/ui/qr_code.dart';
import 'package:inject/inject.dart';
import './ui/lista_nfce.dart';
import 'di/container_d_i.dart';

class App extends StatelessWidget {
  @provide
  App() : super();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) {
          ListaNfceBloc nfceBloc = ContainerDI.container.listaNfceBloc;
          return ListaNfce(key: key,  bloc: nfceBloc);
        },
        '/qr_code': (context) {
          return QrCode(key: key);
        } 
      },
    );
  }
}
