import 'dart:async';

import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import '../resources/repository/nfce_repository.dart';
import 'bloc_base.dart';
import '../models/nfce.dart';

class ListaNfceBloc extends BlocBase {
  final NfceRepository _nfceRepository;
  StreamController<List<NFce>> _nfceFetcher;
  Stream<List<NFce>> get nfces => _nfceFetcher.stream;

  @provide
  ListaNfceBloc(this._nfceRepository);

  init() {
    _nfceFetcher = PublishSubject<List<NFce>>();
  }

  fetchNfces() async {
    var nfces = await _nfceRepository.list();
    _nfceFetcher.sink.add(nfces);
  }

  @override
  void dispose() {
    _nfceFetcher.close();
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
