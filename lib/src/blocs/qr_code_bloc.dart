import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'bloc_base.dart';
import '../services/qr_code_service.dart';
import '../models/qr_code.dart';

class QrCodeBloc extends BlocBase {
  final QrCodeService _qrCodeService;
  final BehaviorSubject<String> _qrCodeController = BehaviorSubject<String>();

  @provide
  QrCodeBloc(this._qrCodeService);

  Function(String) get onQrCodeTextChanged => _qrCodeController.sink.add;

  Stream<String> get qrCodeText => _qrCodeController.stream;

  Future<QrCode> _salvarQrCode() async {
    var qrCodeText = _qrCodeController.value;
    print(qrCodeText);
    var qrCode = QrCode.withQrCode(qrCodeText);
    return await _qrCodeService.salvar(qrCode);
  }

  Future<void> salvar() async {
    await _salvarQrCode();
  }

  Future<void> salvarSincronizar() async {
    var qrCode = await _salvarQrCode();
    await _qrCodeService.sincronizarQrCode(qrCode);
  }

  @override
  void dispose() {
    _qrCodeController?.close();
  }
}
