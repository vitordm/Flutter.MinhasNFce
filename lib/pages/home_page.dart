import 'package:flutter/material.dart';
import 'package:flutter_minhas_nfce/fragments/nfce_list_fragment.dart';

enum Menu {
  Home,
  ListaNFce,
  QrCodes,
  About,
}

class DrawerItem {
  final Menu menu;
  final String title;
  final IconData icon;
  DrawerItem(this.menu, this.title, this.icon);
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  final drawerItens = [
    new DrawerItem(Menu.Home, "Home", Icons.apps),
    new DrawerItem(Menu.ListaNFce, "NFc-e", Icons.format_list_numbered),
    new DrawerItem(Menu.About, "Sobre", Icons.info),
  ];

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Menu _menuSelecionado = Menu.Home;
  String title = "Home";

  _getDrawerItemWidget(Menu menu) {
    this.title = "Home";

    switch (menu) {
      case Menu.Home:
      case Menu.ListaNFce:
        var fragment = NfceListFragment();
        title = fragment.title;
        return fragment;
      default:
        return Text('Error');
    }
  }

  _onSelectItem(Menu menu) {
    setState(() {
      _menuSelecionado = menu;
    });
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    var drawerItens = <Widget>[];
    for (var i = 0; i < widget.drawerItens.length; i++) {
      var drawerItem = widget.drawerItens[i];
      drawerItens.add(ListTile(
        leading: Icon(drawerItem.icon),
        title: Text(drawerItem.title),
        selected: drawerItem.menu == _menuSelecionado,
        onTap: () => _onSelectItem(drawerItem.menu),
      ));
    }

    var fragment = _getDrawerItemWidget(_menuSelecionado);
    FloatingActionButton floatActionButton;
    if (_menuSelecionado == Menu.Home) {
      floatActionButton = FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Increment',
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
            Column(children: drawerItens)
          ],
        ),
      ),
      body: Center(child: fragment),
      floatingActionButton:
          floatActionButton,
    );
  }
}
