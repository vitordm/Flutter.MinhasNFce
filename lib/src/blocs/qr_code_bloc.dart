import 'dart:async';

import 'package:inject/inject.dart';
import 'bloc_base.dart';
import '../services/qr_code_service.dart';
import '../models/qr_code.dart';

class QrCodeBloc extends BlocBase {
  final QrCodeService _qrCodeService;

  final _salvarQrCodeController = StreamController<QrCode>.broadcast();
  StreamSink<QrCode> get salvarQrCode => _salvarQrCodeController.sink;

  @provide
  QrCodeBloc(this._qrCodeService) {
    _salvarQrCodeController.stream.listen(_salvarQrCode);
  }

  Future<QrCode> _salvarQrCode(QrCode qrCode) async {
    return await _qrCodeService.salvar(qrCode);
  }

  Future<void> salvarSincronizar(QrCode qrCode) async {
    qrCode = await _salvarQrCode(qrCode);
    await _qrCodeService.sincronizarQrCode(qrCode);
  }

  @override
  void dispose() {
    _salvarQrCodeController.close();
  }
}
