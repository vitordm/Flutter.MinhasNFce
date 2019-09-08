import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import '../models/qr_code.dart' as Model;

class QrCode extends StatefulWidget {
  QrCode({Key key}) : super(key: key);

  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  bool isEdit = false;

  Model.QrCode qrCode;
  TextEditingController controllerQrCode;

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
    var title = 'Novo QrCode';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            tooltip: 'Salvar Registro',
            onPressed: () => {_saveQrCode()},
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
              onPressed: () => {_scanQrCode()},
            )
          ],
        ),
      ),
    );
  }

  void moveBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _saveQrCode() async {
    if (qrCode == null) {
      qrCode = Model.QrCode();
    }

    qrCode.qrCode = controllerQrCode.text;
    print(qrCode.qrCode);
    // if (!isEdit) {
    //   await _qrCodeService.insert(qrCode);
    // }

    moveBack(context);
  }

  void _scanQrCode() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() {
        controllerQrCode.text = barcode;
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
