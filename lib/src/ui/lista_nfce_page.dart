import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inject/inject.dart';
import '../ui/qr_code_page.dart';
import '../blocs/lista_nfce_bloc.dart';
import '../models/nfce.dart';

class ListaNfcePage extends StatefulWidget {
  final title = "Minhas NFc-e";
  @provide
  final ListaNfceBloc bloc;

  ListaNfcePage({Key key, this.bloc}) : super(key: key);

  _ListaNfcePageState createState() => _ListaNfcePageState();
}

class _ListaNfcePageState extends State<ListaNfcePage> {
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
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Center(child: CircularProgressIndicator());
            }),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22.0),
          closeManually: false,
          curve: Curves.bounceIn,
          onOpen: () => print('OPENING DIAL'),
          onClose: () => print('DIAL CLOSED'),
          tooltip: 'Menu',
          heroTag: 'menu-hero-tag',
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          elevation: 8.0,
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
                child: Icon(FontAwesomeIcons.listAlt),
                backgroundColor: Colors.deepOrange,
                label: 'Qr Codes',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () {
                  Navigator.of(context).pushNamed('/lista_qr_code').then((_) {
                    setState(() {
                      widget.bloc.fetchNfces();
                    });
                  });
                }),
            SpeedDialChild(
                child: Icon(FontAwesomeIcons.qrcode),
                backgroundColor: Colors.green,
                label: 'Novo QrCode',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/qr_code',
                          arguments: QrCodeModoSalvar.SALVAR_SINCRONIZAR)
                      .then((_) {
                    setState(() {
                      widget.bloc.fetchNfces();
                    });
                  });
                }),
            SpeedDialChild(
              child: Icon(
                FontAwesomeIcons.info,
                size: 18,
              ),
              backgroundColor: Colors.grey,
              label: 'Sobre',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => Navigator.of(context).pushNamed('/sobre'),
            )
          ],
        ));
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
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: Key(UniqueKey().toString()),
      background: Container(
          alignment: AlignmentDirectional.centerEnd,
          color: Colors.red,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          )),
      onDismissed: (DismissDirection direction) {
        setState(() async {
          await widget.bloc.deletar(nfc);
          widget.bloc.fetchNfces();
        });
      },
      child: ListTile(
        title: Text(
          nfc.numeroSerie,
          style: _biggerFont,
        ),
        subtitle: Text(nfc.comercio.toString()),
        leading: Icon(FontAwesomeIcons.fileContract),
        /*
        trailing: new Icon(FontAwesomeIcons.fileContract),
      leading: new Icon(
        Icons.attachment,
        color: Colors.red,
      ),*/
        onTap: () => Navigator.of(context).pushNamed('/nfce', arguments: nfc),
      ),
    );
  }
}
