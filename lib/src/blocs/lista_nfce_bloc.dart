import 'dart:async';

import 'package:inject/inject.dart';
import '../resources/repository/nfce_repository.dart';
import 'bloc_base.dart';
import '../models/nfce.dart';

class ListaNfceBloc extends BlocBase {
  final NfceRepository _nfceRepository;
  StreamController<List<NFce>> _nfceFetcher = StreamController<List<NFce>>();
  Stream<List<NFce>> get nfces => _nfceFetcher.stream;

  @provide
  ListaNfceBloc(this._nfceRepository);

  init() {
  }

  fetchNfces() async {
    var nfces = await _nfceRepository.list();
    if (_nfceFetcher == null)
      init();
    _nfceFetcher.sink.add(nfces);
  }

  @override
  void dispose() {
    _nfceFetcher.close();
  }

  Future<void> deletar(NFce nfce) async {
    await _nfceRepository.delete(nfce);
  }
}
/* final List<NFce> nfces = List.from([
    NFce(1, 100, 4).resolveSomething(
        NFceComercio.withRazaoSocial('ZFr Comercio', '00.000.000/0001-88')),
    NFce(1, 101, 4).resolveSomething(
        NFceComercio.withRazaoSocial('Teste Casa', '00.000.000/0002-88')),
    NFce(1, 102, 4).resolveSomething(
        NFceComercio.withRazaoSocial('Barney Chips', '00.000.000/0003-88')),
    NFce(1, 103, 4).resolveSomething(
        NFceComercio.withRazaoSocial('ZFr Comercio', '00.000.000/0001-88')),
  ]);*/
