import 'package:flutter/material.dart';
import 'package:flutter_minhas_nfce/models/nfce.dart';
import 'package:flutter_minhas_nfce/models/nfce_comercio.dart';

class NfceListFragment extends StatefulWidget {
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

  @override
  State<StatefulWidget> createState() => NfceListFragmentState();
}

class NfceListFragmentState extends State<NfceListFragment> {
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return _buildList();
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
      subtitle: Text(nfc.nFceComercio.toString()),
      trailing: new Icon(Icons.attachment),
      leading: new Icon(Icons.attachment, color: Colors.red,),
      onTap: () {
        setState(() {});
      },
    );
  }
}
