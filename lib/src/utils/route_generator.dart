import 'package:flutter/material.dart';
import 'package:flutter_minhas_nfce/src/ui/nfce_page.dart';
import '../blocs/lista_nfce_bloc.dart';
import '../blocs/lista_qr_code.bloc.dart';
import '../blocs/qr_code_bloc.dart';
import '../di/container_d_i.dart';
import '../ui/lista_nfce_page.dart';
import '../ui/lista_qr_code_page.dart';
import '../ui/qr_code_page.dart';
import '../ui/sobre_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) {
          ListaNfceBloc nfceBloc = ContainerDI.container.listaNfceBloc;
          return ListaNfcePage(bloc: nfceBloc);
        });
      case '/nfce':
        return MaterialPageRoute(builder: (_) => NfcePage(nfce: args));
      case '/lista_qr_code':
        return MaterialPageRoute(builder: (_) {
          ListaQrCodeBloc listaQrCodeBloc =
              ContainerDI.container.listaQrCodeBloc;
          return ListaQrCodePage(bloc: listaQrCodeBloc);
        });
      case '/qr_code':
        return MaterialPageRoute(builder: (_) {
          QrCodeBloc qrCodeBloc = ContainerDI.container.qrCodeBloc;
          var modoSalvar = (args is QrCodeModoSalvar) ? args : QrCodeModoSalvar.SALVAR;
          return QrCodePage(bloc: qrCodeBloc, modoSalvar: modoSalvar);
        });
      case '/sobre':
      default:
        return MaterialPageRoute(builder: (_) => SobrePage());
    }
  }
}
