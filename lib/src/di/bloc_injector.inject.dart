import 'bloc_injector.dart' as _i1;
import 'bloc_module.dart' as _i2;
import '../resources/database_provider.dart' as _i3;
import '../resources/repository/nfce_repository.dart' as _i4;
import '../resources/repository/qr_code_repository.dart' as _i5;
import 'dart:async' as _i6;
import '../app.dart' as _i7;
import '../blocs/lista_nfce_bloc.dart' as _i8;
import '../blocs/qr_code_bloc.dart' as _i9;
import '../services/qr_code_service.dart' as _i10;

class BlocInjector$Injector implements _i1.BlocInjector {
  BlocInjector$Injector._(this._blocModule);

  final _i2.BlocModule _blocModule;

  _i3.DatabaseProvider _singletonDatabaseProvider;

  _i4.NfceRepository _singletonNfceRepository;

  _i5.QrCodeRepository _singletonQrCodeRepository;

  static _i6.Future<_i1.BlocInjector> create(_i2.BlocModule blocModule) async {
    final injector = BlocInjector$Injector._(blocModule);

    return injector;
  }

  _i7.App _createApp() => _i7.App();
  _i8.ListaNfceBloc _createListaNfceBloc() =>
      _blocModule.listaNfceBloc(_createNfceRepository());
  _i4.NfceRepository _createNfceRepository() => _singletonNfceRepository ??=
      _blocModule.nfceRepository(_createDatabaseProvider());
  _i3.DatabaseProvider _createDatabaseProvider() =>
      _singletonDatabaseProvider ??= _blocModule.databaseProvider();
  _i9.QrCodeBloc _createQrCodeBloc() =>
      _blocModule.qrCodeBloc(_createQrCodeService());
  _i10.QrCodeService _createQrCodeService() => _blocModule.qrCodeService(
      _createNfceRepository(), _createQrCodeRepository());
  _i5.QrCodeRepository _createQrCodeRepository() =>
      _singletonQrCodeRepository ??=
          _blocModule.qrCodeRepository(_createDatabaseProvider());
  @override
  _i7.App get app => _createApp();
  @override
  _i8.ListaNfceBloc get listaNfceBloc => _createListaNfceBloc();
  @override
  _i9.QrCodeBloc get qrCodeBloc => _createQrCodeBloc();
}
