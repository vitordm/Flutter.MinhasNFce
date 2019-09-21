import 'dart:async';

import 'package:flutter_minhas_nfce/src/services/qr_code_service.dart';
import 'package:inject/inject.dart';
import '../models/qr_code.dart';
import '../resources/repository/qr_code_repository.dart';
import 'bloc_base.dart';

class ListaQrCodeBloc extends BlocBase {
  final QrCodeRepository _qrCodeRepository;
  final QrCodeService _qrCodeService;
  final StreamController<List<QrCode>> _qrCodeFetcher = StreamController<List<QrCode>>();
  Stream<List<QrCode>> get qrCodes => _qrCodeFetcher.stream;

  @provide
  ListaQrCodeBloc(this._qrCodeRepository, this._qrCodeService);

  init() {
  }

  fetchQrCodes() async {
    var qrCodes = await _qrCodeRepository.list();
    if (_qrCodeFetcher == null) {
      init();
    }
    _qrCodeFetcher.sink.add(qrCodes);
  }

  Future<void> deletar(QrCode qrCode) async {
    await _qrCodeRepository.delete(qrCode);
  } 

  @override
  void dispose() {
    _qrCodeFetcher.close();
  }

  Future<void> sincronizar(QrCode qrCode) async {
    await _qrCodeService.sincronizarQrCode(qrCode);
    this.fetchQrCodes();
  }
}
