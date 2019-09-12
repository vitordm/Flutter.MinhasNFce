import 'package:inject/inject.dart';
import 'bloc_module.dart';
import 'bloc_injector.inject.dart' as g;
import '../app.dart';
import '../blocs/lista_nfce_bloc.dart';
import '../blocs/qr_code_bloc.dart';
import '../blocs/lista_qr_code_.bloc.dart';

@Injector(const [BlocModule])
abstract class BlocInjector {
  @provide
  App get app;

  @provide
  ListaNfceBloc get listaNfceBloc;

  @provide
  QrCodeBloc get qrCodeBloc;

  @provide
  ListaQrCodeBloc get listaQrCodeBloc;

  static final create = g.BlocInjector$Injector.create;
}
