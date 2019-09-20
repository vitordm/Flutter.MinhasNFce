import 'dart:async';

import 'package:inject/inject.dart';
import '../models/qr_code.dart';
import '../resources/repository/qr_code_repository.dart';
import 'bloc_base.dart';

class ListaQrCodeBloc extends BlocBase {
  final QrCodeRepository _qrCodeRepository;
  final StreamController<List<QrCode>> _qrCodeFetcher = StreamController<List<QrCode>>();
  Stream<List<QrCode>> get qrCodes => _qrCodeFetcher.stream;

  @provide
  ListaQrCodeBloc(this._qrCodeRepository);

  init() {
  }

  fetchQrCodes() async {
    var qrCodes = await _qrCodeRepository.list();
    _qrCodeFetcher.sink.add(qrCodes);
  }

  Future<void> deletar(QrCode qrCode) async {
    await _qrCodeRepository.delete(qrCode);
  } 

  @override
  void dispose() {
    _qrCodeFetcher.close();
  }
}
