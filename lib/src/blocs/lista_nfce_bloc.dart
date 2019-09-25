import 'dart:async';
import 'package:inject/inject.dart';
import 'bloc_base.dart';
import '../resources/repository/nfce_repository.dart';
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
