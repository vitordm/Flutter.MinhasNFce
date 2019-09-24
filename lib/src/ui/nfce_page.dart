import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/nfce.dart';

class NfcePage extends StatelessWidget {
  final NFce nfce;

  const NfcePage({Key key, @required this.nfce}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cnpj = nfce.comercio.cnpj;

    var dataNfce = new DateFormat('dd/MM/yyyy HH:mm:ss').format(nfce.dataNfce);
    var valorPago =
        (nfce.valorPago != null ? nfce.valorPago.toString() : 'N/A');
    var formaPagamento =
        nfce.formaPagamento != null ? nfce.formaPagamento : 'N/A';
    var consumidor = nfce.consumidorIdentificado
        ? nfce.documentoConsumidor
        : 'Não Identificado';
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          title: Text("NFc-e"),
        ),
        body: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Padding(
                child: Text("${nfce.comercio.razaoSocial}",
                    textAlign: TextAlign.center),
                padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
              ),
            ]),
            Row(
              children: <Widget>[
                Padding(
                  child: Text("CNPJ: $cnpj"),
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                ),
                Padding(
                  child: Text("IE: ${nfce.comercio.ie} "),
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                )
              ],
            ),
            Container(
              child: Padding(
                child: Text(nfce.comercio.endereco),
                padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
              ),
            ),
            Divider(),
            Row(
              children: <Widget>[
                Padding(
                  child: Text("Número: ${nfce.numero}-${nfce.serie}"),
                  padding: EdgeInsets.fromLTRB(8, 5, 0, 5),
                ),
                Padding(
                  child: Text("Data: $dataNfce"),
                  padding: EdgeInsets.fromLTRB(0, 5, 8, 5),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  child: Text(
                      "Total Descontos: ${nfce.valorDesconto.toString()} Total: ${nfce.valorTotal.toString()} "),
                  padding: EdgeInsets.fromLTRB(8, 5, 0, 5),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  child: Text(
                      "Total Pago: $valorPago Forma Pagamento: $formaPagamento "),
                  padding: EdgeInsets.fromLTRB(8, 5, 0, 5),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  child: Text("Consumidor: $consumidor"),
                  padding: EdgeInsets.fromLTRB(8, 5, 0, 5),
                ),
              ],
            ),
            Expanded(
              child: Container(
                child: buildTableItens2(),
              ),
            )
          ],
        ));
  }

  Widget buildTableItens() {
    List<DataRow> itens = nfce.itens
        .map((item) => DataRow(
              cells: <DataCell>[
                DataCell(
                    Text(
                      item.codigo,
                      textAlign: TextAlign.center,
                    ),
                    showEditIcon: false,
                    placeholder: false),
                DataCell(Text(item.descricao, textAlign: TextAlign.left),
                    showEditIcon: false, placeholder: false),
                DataCell(Text(item.qtde.toString(), textAlign: TextAlign.right),
                    showEditIcon: false, placeholder: false),
                DataCell(Text(item.un, textAlign: TextAlign.center),
                    showEditIcon: false, placeholder: false),
                DataCell(
                    Text(item.valorUnitario.toString(),
                        textAlign: TextAlign.right),
                    showEditIcon: false,
                    placeholder: false),
                DataCell(
                    Text(item.valorTotal.toString(),
                        textAlign: TextAlign.right),
                    showEditIcon: false,
                    placeholder: false),
              ],
            ))
        .toList();

    var table = DataTable(
      columnSpacing: 3,
      dataRowHeight: 25,
      headingRowHeight: 25,
      horizontalMargin: 8,
      columns: <DataColumn>[
        DataColumn(
            label: Text('Código',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold)),
            numeric: false,
            tooltip: 'Código do produto'),
        DataColumn(
            label: Text('Descrição',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold)),
            numeric: false,
            tooltip: 'Descrição do produto'),
        DataColumn(
          label: Text('Qtd.',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold)),
          numeric: true,
          tooltip: 'Quantidade',
        ),
        DataColumn(
            label: Text('UN',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold)),
            numeric: false,
            tooltip: 'UN do produto'),
        DataColumn(
            label: Text('Valor',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold)),
            numeric: true,
            tooltip: 'Valor Unitário'),
        DataColumn(
            label: Text('Total',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold)),
            numeric: true,
            tooltip: 'Total'),
      ],
      rows: itens,
    );

    /*
    return BidirectionalScrollViewPlugin(
      child: table,
      scrollDirection: ScrollDirection.both,
    );*/

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: table,
      ),
    );
  }

  Widget buildTableItens2() {
    final textStyleHeader = TextStyle(fontSize: 8, fontWeight: FontWeight.bold);

    var rows = <TableRow>[
      TableRow(children: <Widget>[
        TableCell(
            child: Container(
          color: Colors.grey,
          child: Text("Código",
              style: textStyleHeader, textAlign: TextAlign.center),
        )),
        TableCell(
            child: Container(
                color: Colors.grey,
                child: Text("Descrição",
                    style: textStyleHeader, textAlign: TextAlign.center))),
        TableCell(
            child: Container(
                color: Colors.grey,
                child: Text("Qtd.",
                    style: textStyleHeader, textAlign: TextAlign.center))),
        TableCell(
            child: Container(
                color: Colors.grey,
                child: Text("UN",
                    style: textStyleHeader, textAlign: TextAlign.center))),
        TableCell(
            child: Container(
                color: Colors.grey,
                child: Text("Valor",
                    style: textStyleHeader, textAlign: TextAlign.center))),
        TableCell(
            child: Container(
                color: Colors.grey,
                child: Text("Total",
                    style: textStyleHeader, textAlign: TextAlign.center))),
      ])
    ];

    final textStyle = TextStyle(fontSize: 10);
    for (var item in nfce.itens) {
      rows.add(TableRow(children: <Widget>[
        TableCell(
            child: Text(item.codigo,
                style: TextStyle(fontSize: 8), textAlign: TextAlign.center)),
        TableCell(
            child: Text(item.descricao,
                style: TextStyle(fontSize: 8), textAlign: TextAlign.left)),
        TableCell(
            child: Text(item.qtde.toString(),
                style: textStyle, textAlign: TextAlign.right)),
        TableCell(
            child:
                Text(item.un, style: textStyle, textAlign: TextAlign.center)),
        TableCell(
            child: Text(item.valorUnitario.toString(),
                style: textStyle, textAlign: TextAlign.right)),
        TableCell(
            child: Text(item.valorTotal.toString(),
                style: textStyle, textAlign: TextAlign.right)),
      ]));
    }

    var table = Table(
      border: TableBorder.all(color: Colors.grey, width: 0.5),
      children: rows,
    );

    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.fromLTRB(3, 0, 3, 5),
          child: table,
        ));
  }
}
