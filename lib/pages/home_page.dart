import 'package:flutter/material.dart';

class DrawerItem {
  final String title;
  final IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  final String title = 'Flutter MyMinhasNFc-e';
  final drawerItens = [
    new DrawerItem("Fragment 1", Icons.adb),
    new DrawerItem("Fragment 2", Icons.add_to_queue),
    new DrawerItem("Fragment 3", Icons.info),
  ];

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      /*
      case 1:
        return Fragment();
        
      */
      default:
        return Text('Error');
    }
  }

  _onSelectItem(int index) {
    setState(() {
      _selectedDrawerIndex = index;
    });
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {

    var drawerItens = <Widget>[];
    var i = 0;
    for (var drawerItem in widget.drawerItens) {
      drawerItens.add(ListTile(
                leading: Icon(drawerItem.icon),
                title: Text(drawerItem.title),
                selected: i == _selectedDrawerIndex,
                onTap: () => _onSelectItem(i),
              ));
              i++;
    }


    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
      body: Center(
        child: _getDrawerItemWidget(_selectedDrawerIndex)
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
