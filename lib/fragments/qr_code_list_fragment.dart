import 'package:flutter/material.dart';
import 'package:flutter_minhas_nfce/models/qr_code.dart';
import 'package:flutter_minhas_nfce/services/qr_code_service.dart';

class QrCodeListFragment extends StatefulWidget {

  @override
  State createState() => QrCodeListFragmentState();
}

class QrCodeListFragmentState extends State<QrCodeListFragment> {

  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _qrCodeService = QrCodeService();
  final qrCodes = List<QrCode>();


  @override
  Widget build(BuildContext context) async {
    //var qrCodesList = await _qrCodeService.List();
    qrCodes.clear();
    qrCodes.addAll(qrCodesList);
    //return _buildList();
  }

  _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        final index = i ~/ 2;
        if (index >= widget.nfces.length) {
          return null;
        }

        return _buildRow(widget.nfces[index]);
      },
    );
  }

  _buildRow(NFce nfc) {
    return ListTile(
      title: Text(
        nfc.numeroSerie,
        style: _biggerFont,
      ),
      subtitle: Text(nfc.comercio.toString()),
      trailing: new Icon(Icons.attachment),
      leading: new Icon(Icons.attachment, color: Colors.red,),
      onTap: () {
        setState(() {});
      },
    );
  }

}