import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_minhas_nfce/models/qr_code.dart';
import 'package:flutter_minhas_nfce/services/qr_code_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QrCodePage extends StatefulWidget {
  final QrCode qrCode;

  QrCodePage(this.qrCode, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => QrCodePageState(qrCode);
}

class QrCodePageState extends State<QrCodePage> {
  final _qrCodeService = QrCodeService();
  bool isEdit = false;

  QrCode qrCode;
  TextEditingController controllerQrCode;
  QrCodePageState(this.qrCode);

  @override
  void initState() {

    if (qrCode != null) {
      isEdit = true;
    }

    controllerQrCode =
        TextEditingController(text: (qrCode != null) ? qrCode.qrCode : '');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var title = isEdit ? 'Novo QrCode' : 'Editar QrCode';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            tooltip: 'Salvar Registro',
            onPressed: () => {
                _salvarQrCode()
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: controllerQrCode,
              decoration: InputDecoration(
                  hintText: 'Digite o QrCode',
                  labelText: 'QrCode',
                  labelStyle: TextStyle(fontSize: 20.0)),
            ),
            Container(
              height: 20,
            ),
            RaisedButton.icon(
              icon: Icon(
                FontAwesomeIcons.qrcode,
                color: Colors.white,
              ),
              label: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text('CAMERA',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
              color: Colors.lightBlue,
              onPressed: () => {},
            )
          ],
        ),
      ),
    );
  }

  void moveBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _salvarQrCode() async {
    if (qrCode == null) {
      qrCode = QrCode();
    }

    qrCode.qrCode = controllerQrCode.text;
    if (!isEdit) {
      await _qrCodeService.insert(qrCode);
    }

    moveBack(context);
  }
}
