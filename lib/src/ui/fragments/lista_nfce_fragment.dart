import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import '../../blocs/lista_nfce_bloc.dart';
import '../../models/nfce.dart';

class ListaNfceFragment extends StatefulWidget {
  final title = "Minhas NFc-e";
  @provide
  final ListaNfceBloc bloc;

  ListaNfceFragment({Key key, this.bloc}) : super(key: key);

  _ListaNfceFragmentState createState() => _ListaNfceFragmentState();
}

class _ListaNfceFragmentState extends State<ListaNfceFragment> {
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
    return StreamBuilder(
        stream: widget.bloc.nfces,
        builder: (context, AsyncSnapshot<List<NFce>> snapshot) {
          if (snapshot.hasData) {
            return _buildList(snapshot.data);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        });
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
