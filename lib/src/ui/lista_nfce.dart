import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../blocs/lista_nfce_bloc.dart';
import '../models/nfce.dart';

class ListaNfce extends StatefulWidget {
  final title = "Minhas NFc-e";
  final ListaNfceBloc bloc = ListaNfceBloc();

  ListaNfce({Key key}) : super(key: key);

  _ListaNfceState createState() => _ListaNfceState();
}

class _ListaNfceState extends State<ListaNfce> {
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  void initState() {
    super.initState();
    widget.bloc.init();
    widget.bloc.fetchNfces();
  }

  @override
  void dispose() {
    super.dispose();
    widget.bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder(
          stream: widget.bloc.nfces,
          builder: (context, AsyncSnapshot<List<NFce>> snapshot) {
            if (snapshot.hasData) {
              return _buildList(snapshot.data);
            }
            else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Nova NFc-e',
        child: Icon(FontAwesomeIcons.qrcode),
      ),
    );
  }

  _buildList(List<NFce> data) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        final index = i ~/ 2;
        if (index >= data.length) {
          return null;
        }

        return _buildRow(data[index]);
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
