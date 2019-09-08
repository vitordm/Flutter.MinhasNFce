import 'bloc_injector.dart' as _i1;
import 'bloc_module.dart' as _i2;
import '../resources/database_provider.dart' as _i3;
import '../resources/repository/nfce_repository.dart' as _i4;
import 'dart:async' as _i5;
import '../app.dart' as _i6;
import '../blocs/lista_nfce_bloc.dart' as _i7;

class BlocInjector$Injector implements _i1.BlocInjector {
  BlocInjector$Injector._(this._blocModule);

  final _i2.BlocModule _blocModule;

  _i3.DatabaseProvider _singletonDatabaseProvider;

  _i4.NfceRepository _singletonNfceRepository;

  static _i5.Future<_i1.BlocInjector> create(_i2.BlocModule blocModule) async {
    final injector = BlocInjector$Injector._(blocModule);

    return injector;
  }

  _i6.App _createApp() => _i6.App();
  _i7.ListaNfceBloc _createListaNfceBloc() =>
      _blocModule.listaNfceBloc(_createNfceRepository());
  _i4.NfceRepository _createNfceRepository() => _singletonNfceRepository ??=
      _blocModule.nfceRepository(_createDatabaseProvider());
  _i3.DatabaseProvider _createDatabaseProvider() =>
      _singletonDatabaseProvider ??= _blocModule.databaseProvider();
  @override
  _i6.App get app => _createApp();
  @override
  _i7.ListaNfceBloc get listaNfceBloc => _createListaNfceBloc();
}
