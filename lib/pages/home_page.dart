import 'package:flutter/material.dart';
import 'package:flutter_minhas_nfce/fragments/nfce_list_fragment.dart';
import 'package:flutter_minhas_nfce/fragments/qr_code_list_fragment.dart';
import 'package:flutter_minhas_nfce/pages/qr_code_page.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Menu {
  Home,
  ListaNFce,
  QrCodes,
  About,
}

class MenuItem {
  final Menu menu;
  final String title;
  final IconData icon;
  MenuItem(this.menu, this.title, this.icon);
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  final menuItens = [
    new MenuItem(Menu.Home, 'Home', Icons.apps),
    //new DrawerItem(Menu.ListaNFce, "NFc-e", Icons.format_list_numbered),
    new MenuItem(Menu.QrCodes, 'QrCodes', FontAwesomeIcons.qrcode),
    new MenuItem(Menu.About, "Sobre", Icons.info),
  ];

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  MenuItem _menuSelecionado;
  String title = "Home";


  @override
  void initState() {
    _menuSelecionado = widget.menuItens[0];
  }

  _getDrawerItemWidget(MenuItem menuItem) {
    this.title = menuItem.title;

    switch (menuItem.menu) {
      case Menu.Home:
      case Menu.ListaNFce:
        var fragment = NfceListFragment();
        title = fragment.title;
        return fragment;
      case Menu.QrCodes:
        return QrCodeListFragment();
      default:
        return Text('Error');
    }
  }

  _onSelectItem(MenuItem menu) {
    setState(() {
      _menuSelecionado = menu;
    });
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    var menuItens = <Widget>[];
    for (var i = 0; i < widget.menuItens.length; i++) {
      var menuItem = widget.menuItens[i];
      menuItens.add(ListTile(
        leading: Icon(menuItem.icon),
        title: Text(menuItem.title),
        selected: menuItem.menu == _menuSelecionado.menu,
        onTap: () => _onSelectItem(menuItem),
      ));
    }

    var fragment = _getDrawerItemWidget(_menuSelecionado);
    FloatingActionButton floatActionButton;
    if ([Menu.Home, Menu.QrCodes].contains(_menuSelecionado.menu)) {
      floatActionButton = FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => QrCodePage(null),
            )),
        tooltip: 'Nova NFc-e',
        child: Icon(Icons.add),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      drawer: new Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Minhas NFc-e'),
              accountEmail: null,
            ),
            Column(children: menuItens)
          ],
        ),
      ),
      body: fragment,
      floatingActionButton: floatActionButton,
    );
  }
}
