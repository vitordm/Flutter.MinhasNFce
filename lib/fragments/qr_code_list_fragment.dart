import 'package:flutter/material.dart';
import 'package:flutter_minhas_nfce/models/qr_code.dart';
import 'package:flutter_minhas_nfce/services/qr_code_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class QrCodeListFragment extends StatefulWidget {
  @override
  State createState() => QrCodeListFragmentState();
}

class QrCodeListFragmentState extends State<QrCodeListFragment> {
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _qrCodeService = QrCodeService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QrCode>>(
        future: _qrCodeService.list(),
        builder: (BuildContext context, AsyncSnapshot<List<QrCode>> snapshot) {
          if (snapshot.hasData) {
            return _buildList(snapshot.data);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  _buildList(List<QrCode> qrCodeList) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        final index = i ~/ 2;
        if (index >= qrCodeList.length) {
          return null;
        }

        return _buildRow(qrCodeList[index]);
      },
    );
  }

  _buildRow(QrCode qrCode) {
    var formatter = new DateFormat('dd/MM/yyyy H:m:s');

    return ListTile(
      title: Text(
        qrCode.qrCode,
        style: _biggerFont,
      ),
      subtitle: Text(formatter.format(qrCode.criadoEm)),
      leading: new Icon(
        FontAwesomeIcons.qrcode,
        color: qrCode.sincronizado ? Colors.blueAccent : Colors.blueGrey,
      ),
      onTap: () {
        setState(() {});
      },
    );
  }
}
