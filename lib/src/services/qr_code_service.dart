import 'package:inject/inject.dart';
import 'package:vitor_myparser_nfce/my_parser_nfce.dart';

import '../models/nfce.dart';
import '../models/qr_code.dart';
import '../resources/repository/nfce_repository.dart';
import '../resources/repository/qr_code_repository.dart';

class QrCodeService {
  final NfceRepository _nfceRepository;
  final QrCodeRepository _qrCodeRepository;

  @provide
  QrCodeService(this._nfceRepository, this._qrCodeRepository);

  Future<QrCode> salvar(QrCode qrCode) async {
    if (qrCode.id != null && qrCode.id > 0) {
      return _qrCodeRepository.atualizar(qrCode);
    }

    return await _qrCodeRepository.insert(qrCode);
  }

  Future<NFce> sincronizarQrCode(QrCode qrCode) async {
    NFce nfce;
    try {
      var myParserNFceFactory = MyParserNFceFactory(qrCode.qrCode);
      var downloadNfce = await myParserNFceFactory.make();
      if (downloadNfce !=null) {
        nfce = NFce.fromMap(downloadNfce.toMap());
        nfce = await _nfceRepository.insert(nfce);
      }
    } catch(e) {
      print(e);
    }
    return nfce;
  }
}