import 'package:flutter/material.dart';
import 'package:flutter_minhas_nfce/src/ui/sobre.dart';
import 'package:inject/inject.dart';
import './blocs/lista_nfce_bloc.dart';
import './blocs/qr_code_bloc.dart';
import './blocs/lista_qr_code_.bloc.dart';
import './ui/lista_nfce.dart';
import './ui/qr_code.dart';
import './ui/lista_qr_code.dart';
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
        '/lista_nfce': (context) {
          ListaNfceBloc nfceBloc = ContainerDI.container.listaNfceBloc;
          return ListaNfce(key: key,  bloc: nfceBloc);
        },
        '/lista_qr_code': (context) {
          ListaQrCodeBloc listaQrCodeBloc = ContainerDI.container.listaQrCodeBloc;
          return ListaQrCode(key: key, bloc: listaQrCodeBloc);
        },
        '/qr_code': (context) {
          QrCodeBloc qrCodeBloc = ContainerDI.container.qrCodeBloc;
          return QrCode(key: key, bloc: qrCodeBloc);
        },
        '/sobre' : (context) {
          return Sobre();
        }
      },
    );
  }
}
