import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/qr_code.dart';
import '../blocs/lista_qr_code_.bloc.dart';

class ListaQrCode extends StatefulWidget {
  final ListaQrCodeBloc bloc;
  ListaQrCode({Key key, this.bloc}) : super(key: key);

  _ListaQrCodeState createState() => _ListaQrCodeState();
}

class _ListaQrCodeState extends State<ListaQrCode> {
  @override
  void initState() {
    super.initState();
    widget.bloc.init();
    widget.bloc.fetchQrCodes();
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
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
        onRefresh: () {
          setState(() {
            widget.bloc.fetchQrCodes();
          });
          return null;
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(FontAwesomeIcons.qrcode),
        backgroundColor: Colors.green,
        onPressed: () => Navigator.of(context).pushNamed('/qr_code'),
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
          )),
    );
  }
}
