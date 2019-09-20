import 'package:http/http.dart';
import 'package:inject/inject.dart';
import '../blocs/lista_nfce_bloc.dart';
import '../blocs/qr_code_bloc.dart';
import '../blocs/lista_qr_code.bloc.dart';
import '../resources/database_provider.dart';
import '../resources/repository/nfce_repository.dart';
import '../resources/repository/qr_code_repository.dart';
import '../services/qr_code_service.dart';

@module
class BlocModule {
  @provide
  @singleton
  Client client() => Client();

  @provide
  @singleton
  DatabaseProvider databaseProvider() => DatabaseProvider();

  @provide
  @singleton
  NfceRepository nfceRepository(DatabaseProvider databaseProvider) =>
      NfceRepository(databaseProvider);

  @provide
  @singleton
  QrCodeRepository qrCodeRepository(DatabaseProvider databaseProvider) =>
      QrCodeRepository(databaseProvider);

  @provide
  @singleton
  QrCodeService qrCodeService(
          NfceRepository nfceRepository, QrCodeRepository qrCodeRepository) =>
      QrCodeService(nfceRepository, qrCodeRepository);

  @provide
  ListaNfceBloc listaNfceBloc(NfceRepository repository) =>
      ListaNfceBloc(repository);

  @provide
  QrCodeBloc qrCodeBloc(QrCodeService qrCodeService) =>
      QrCodeBloc(qrCodeService);

  @provide
  ListaQrCodeBloc listaQrCodeBloc(QrCodeRepository repository) =>
      ListaQrCodeBloc(repository);
}
