import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/qr_code.dart';
import '../blocs/lista_qr_code.bloc.dart';

class ListaQrCodePage extends StatefulWidget {
  final ListaQrCodeBloc bloc;

  ListaQrCodePage({Key key, this.bloc}) : super(key: key);

  _ListaQrCodePageState createState() => _ListaQrCodePageState();
}

class _ListaQrCodePageState extends State<ListaQrCodePage> {
  @override
  void initState() {
    super.initState();
    widget.bloc.init();
    widget.bloc.fetchQrCodes();
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
        title: Text("Qr Codes"),
      ),
      body: RefreshIndicator(
        child: StreamBuilder(
          stream: widget.bloc.qrCodes,
          initialData: List<QrCode>(),
          builder:
              (BuildContext context, AsyncSnapshot<List<QrCode>> snapshot) {
            if (snapshot.hasData) {
              return _buildList(snapshot.data);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
        onRefresh: () async {
        return await _onRefresh();
        } ,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(FontAwesomeIcons.qrcode),
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.of(context).pushNamed('/qr_code').then((_) {
            widget.bloc.fetchQrCodes();
          });
        },
      ),
    );
  }

  Widget _buildList(List<QrCode> data) {
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

  _buildRow(QrCode qrCode) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: Key(qrCode.id.toString()),
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
      onDismissed: (DismissDirection direction) async {
        await widget.bloc.deletar(qrCode);
        setState(() {
          widget.bloc.fetchQrCodes();
        });
      },
      child: ListTile(
          title: Text(
            qrCode.qrCode ?? '',
            style: const TextStyle(fontSize: 12),
          ),
          subtitle: Text("Id: ${qrCode.id}"),
          leading: new Icon(
            FontAwesomeIcons.qrcode,
            color: qrCode.sincronizado ? Colors.blueAccent : Colors.grey,
          ),
          onLongPress: () {
            if (!qrCode.sincronizado) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: Text('Deseja sincronizar?'),
                        content: Text('Isso irá baixar informações da NFc-e'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Não'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          FlatButton(
                              child: Text('Sim'),
                              onPressed: () async {
                                await widget.bloc.sincronizar(qrCode);
                                Navigator.of(context).pop();
                              }),
                        ],
                      ));
            }
          }),
    );
  }

  Future<Null> _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 500));
    widget.bloc.fetchQrCodes();
    return null;
  }
}
