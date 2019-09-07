import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/nfce.dart';
import '../models/nfce_comercio.dart';

class ListaNfce extends StatefulWidget {
  final title = "Minhas NFc-e";
  final List<NFce> nfces = List.from([
    NFce(1, 100, 4).resolveSomething(
        NFceComercio.withRazaoSocial('ZFr Comercio', '00.000.000/0001-88')),
    NFce(1, 101, 4).resolveSomething(
        NFceComercio.withRazaoSocial('Teste Casa', '00.000.000/0002-88')),
    NFce(1, 102, 4).resolveSomething(
        NFceComercio.withRazaoSocial('Barney Chips', '00.000.000/0003-88')),
    NFce(1, 103, 4).resolveSomething(
        NFceComercio.withRazaoSocial('ZFr Comercio', '00.000.000/0001-88')),
  ]);

  ListaNfce({Key key}) : super(key: key);

  _ListaNfceState createState() => _ListaNfceState();
}

class _ListaNfceState extends State<ListaNfce> {
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Nova NFc-e',
        child: Icon(FontAwesomeIcons.qrcode),
      ),
    );
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
      leading: new Icon(
        Icons.attachment,
        color: Colors.red,
      ),
      onTap: () {
        setState(() {});
      },
    );
  }
}
