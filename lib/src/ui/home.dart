import 'package:flutter/material.dart';
import 'package:flutter_minhas_nfce/src/ui/fragments/sobre_fragment.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'fragments/lista_nfce_fragment.dart';
import 'fragments/lista_qr_code_fragment.dart';
import '../di/container_d_i.dart';
import '../models/menu_item.dart';

class Home extends StatefulWidget {
  final menuItens = [
    //new MenuItem(Menu.Home, 'Home', Icons.apps),
    new MenuItem(Menu.ListaNFce, "Minhas NFc-e", Icons.format_list_numbered),
    new MenuItem(Menu.ListaQrCodes, 'QrCodes', FontAwesomeIcons.qrcode),
    new MenuItem(Menu.About, "Sobre", Icons.info),
  ];

  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  MenuItem _menuItemSelecionado;
  String title = "";

  @override
  void initState() {
    super.initState();
    _menuItemSelecionado = widget.menuItens.first;
  }

  @override
  Widget build(BuildContext context) {
    var fragment = _getWidgetMenu(_menuItemSelecionado);

    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      drawer: new Drawer(
        child: Column(
          children: <Widget>[
            Container(
              height: 90,
              child: DrawerHeader(
                decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                child: SafeArea(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text("Minhas NFc-e",
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white))
                      ]),
                ),
              ),
            ),

            // UserAccountsDrawerHeader(
            //   accountName: Text('Minhas NFc-e'),
            //   accountEmail: null,
            // ),
            Column(children: _buildMenuLateral())
          ],
        ),
      ),
      body: fragment,
    );
  }

  _getWidgetMenu(MenuItem menuItem) {
    title = menuItem.title;
    switch (menuItem.menu) {
      case Menu.ListaNFce:
        return ListaNfceFragment(
            key: widget.key, bloc: ContainerDI.container.listaNfceBloc);
      case Menu.ListaQrCodes:
        return ListaQrCodeFragment(
            key: widget.key, bloc: ContainerDI.container.listaQrCodeBloc);
      case Menu.About:
        return SobreFragment(key: widget.key);
      default:
        return Text("Erro");
    }
  }

  _buildMenuLateral() {
    var menuItens = <Widget>[];
    for (var i = 0; i < widget.menuItens.length; i++) {
      var menuItem = widget.menuItens[i];
      menuItens.add(ListTile(
        leading: Icon(menuItem.icon),
        title: Text(menuItem.title),
        selected: menuItem.menu == _menuItemSelecionado.menu,
        onTap: () => _onSelectItem(menuItem),
      ));
    }
    return menuItens;
  }

  _onSelectItem(MenuItem menu) {
    setState(() {
      _menuItemSelecionado = menu;
    });
    Navigator.of(context).pop(); // close the drawer
  }
}
