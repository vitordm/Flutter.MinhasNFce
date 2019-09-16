import 'package:flutter/material.dart';
import '../blocs/lista_nfce_bloc.dart';
import '../blocs/lista_qr_code_.bloc.dart';
import '../blocs/qr_code_bloc.dart';
import '../di/container_d_i.dart';
import '../ui/lista_nfce.dart';
import '../ui/lista_qr_code.dart';
import '../ui/qr_code.dart';
import '../ui/sobre.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) {
          ListaNfceBloc nfceBloc = ContainerDI.container.listaNfceBloc;
          return ListaNfce(bloc: nfceBloc);
        });
      case '/lista_qr_code':
        return MaterialPageRoute(builder: (_) {
          ListaQrCodeBloc listaQrCodeBloc =
              ContainerDI.container.listaQrCodeBloc;
          return ListaQrCode(bloc: listaQrCodeBloc);
        });
      case '/qr_code':
        return MaterialPageRoute(builder: (_) {
          QrCodeBloc qrCodeBloc = ContainerDI.container.qrCodeBloc;
          var modoSalvar = (args is QrCodeModoSalvar) ? args : QrCodeModoSalvar.SALVAR;
          return QrCode(bloc: qrCodeBloc, modoSalvar: modoSalvar);
        });
      case '/sobre':
      default:
        return MaterialPageRoute(builder: (_) => Sobre());
    }
  }
}
