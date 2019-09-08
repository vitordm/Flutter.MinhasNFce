import 'package:http/http.dart';
import 'package:inject/inject.dart';
import '../blocs/lista_nfce_bloc.dart';
import '../resources/database_provider.dart';
import '../resources/repository/nfce_repository.dart';


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
  NfceRepository nfceRepository(DatabaseProvider databaseProvider) => NfceRepository(databaseProvider);
  
  @provide
  ListaNfceBloc listaNfceBloc(NfceRepository repository) => ListaNfceBloc(repository);

}