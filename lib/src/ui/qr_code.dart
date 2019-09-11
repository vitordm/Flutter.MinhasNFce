import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import '../blocs/qr_code_bloc.dart';

class QrCode extends StatefulWidget {
  final QrCodeBloc bloc;
  QrCode({Key key, this.bloc}) : super(key: key);

  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  TextEditingController controllerQrCode;

  @override
  void initState() {
    super.initState();
    controllerQrCode = TextEditingController();
    controllerQrCode.addListener(() {
      widget.bloc.onQrCodeTextChanged(controllerQrCode.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var title = 'Novo QrCode';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            tooltip: 'Salvar Registro',
            onPressed: () => {_salvarQrCode()},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: TextField(
                maxLines: 5,
                controller: controllerQrCode,
                onChanged: widget.bloc.onQrCodeTextChanged,
                decoration: InputDecoration(
                    hintText: 'Digite o QrCode',
                    labelText: 'QrCode',
                    labelStyle: TextStyle(fontSize: 20.0)),
              ),
            ),
            Container(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: RaisedButton.icon(
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
                onPressed: () => {_scanQrCode()},
              ),
            ),
            Visibility(
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                child: RaisedButton.icon(
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  label: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text("Salvar",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                  color: Colors.blueGrey,
                  onPressed: () {
                    _apenasSalvar();
                  },
                ),
              ),
              visible: controllerQrCode.text.length > 0,
            ),
            Visibility(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                  child: RaisedButton.icon(
                    icon: Icon(FontAwesomeIcons.syncAlt, color: Colors.white),
                    label: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text("Salvar e Sincronizar",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                    color: Colors.indigo,
                    onPressed: () {
                      _salvarQrCode();
                    },
                  )),
              visible: controllerQrCode.text.length > 0,
            )
          ],
        ),
      ),
    );
  }

  void moveBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _salvarQrCode() {
    setState(() async {
      if (controllerQrCode.text.length == 0) return;
      await widget.bloc.salvarSincronizar();
      moveBack(context);
    });
  }

  void _apenasSalvar() async {
    setState(() async {
      if (controllerQrCode.text.length == 0) return;
      await widget.bloc.salvar();
      moveBack(context);
    });
  }

  void _scanQrCode() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() {
        controllerQrCode.text = barcode;
        debugPrint(barcode);
        //widget.bloc.onQrCodeTextChanged(barcode);
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        debugPrint('Unknown error: CameraAccessDenied');
      } else {
        debugPrint('Unknown error: $e');
      }
    } on FormatException {
      debugPrint(
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      debugPrint(e);
    }
  }
}
