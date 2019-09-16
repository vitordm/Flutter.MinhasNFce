import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import '../blocs/qr_code_bloc.dart';
import '../models/qr_code.dart' as Model;

enum QrCodeModoSalvar { SALVAR, SALVAR_SINCRONIZAR }

class QrCode extends StatefulWidget {
  final QrCodeBloc bloc;
  final QrCodeModoSalvar modoSalvar;
  QrCode({Key key, this.bloc, this.modoSalvar}) : super(key: key);

  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  TextEditingController controllerQrCode;

  @override
  void initState() {
    super.initState();
    controllerQrCode = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    widget.bloc.dispose();
    controllerQrCode.dispose();
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
            onPressed: () => {
              if (widget.modoSalvar == QrCodeModoSalvar.SALVAR)
                _apenasSalvar()
              else
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
            Container(
              child: TextField(
                maxLines: 5,
                controller: controllerQrCode,
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
              visible: false, // controllerQrCode.text.length > 0,
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
              visible: false, //controllerQrCode.text.length > 0,
            )
          ],
        ),
      ),
    );
  }

  void moveBack(BuildContext context) {
    Navigator.of(context).pop(true);
  }

  void _salvarQrCode() {
    setState(() async {
      if (controllerQrCode.text.length == 0) return;
      widget.bloc.salvarSincronizar
          .add(Model.QrCode.withQrCode(controllerQrCode.text));
      moveBack(context);
    });
  }

  void _apenasSalvar() async {
    setState(() async {
      if (controllerQrCode.text.length == 0) return;
      widget.bloc.salvarQrCode
          .add(Model.QrCode.withQrCode(controllerQrCode.text));
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
