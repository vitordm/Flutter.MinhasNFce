import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import '../models/qr_code.dart';
import '../resources/repository/qr_code_repository.dart';
import 'bloc_base.dart';

class ListaQrCodeBloc extends BlocBase {
  final QrCodeRepository _qrCodeRepository;
  PublishSubject<List<QrCode>> _qrCodeFetcher;
  Observable<List<QrCode>> get qrCodes => _qrCodeFetcher?.stream;

  @provide
  ListaQrCodeBloc(this._qrCodeRepository);

  init() {
    _qrCodeFetcher = PublishSubject<List<QrCode>>();
  }

  fetchQrCodes() async {
    var qrCodes = await _qrCodeRepository.list();
    _qrCodeFetcher.sink.add(qrCodes);
  }

  @override
  void dispose() {
    _qrCodeFetcher.close();
  }
}
