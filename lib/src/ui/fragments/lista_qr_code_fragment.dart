import 'package:flutter/material.dart';
import '../../models/qr_code.dart';
import '../../blocs/lista_qr_code_.bloc.dart';

class ListaQrCodeFragment extends StatefulWidget {
  final ListaQrCodeBloc bloc;
  ListaQrCodeFragment({Key key, this.bloc}) : super(key: key);

  _ListaQrCodeFragmentState createState() => _ListaQrCodeFragmentState();
}

class _ListaQrCodeFragmentState extends State<ListaQrCodeFragment> {
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
    return StreamBuilder(
      stream: widget.bloc.qrCodes,
      initialData: List<QrCode>(),
      builder: (BuildContext context, AsyncSnapshot<List<QrCode>> snapshot) {
        if (snapshot.hasData) {
          return _buildList(snapshot.data);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
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
    return ListTile(
      title: Text(
        qrCode.qrCode ?? '',
        style: const TextStyle(fontSize: 12),
      ),
      subtitle: Text("Id: ${qrCode.id}"),
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
