import 'package:flutter/material.dart';

enum Menu {
  Home,
  ListaNFce,
  ListaQrCodes,
  About,
}

class MenuItem {
  final Menu menu;
  final String title;
  final IconData icon;
  MenuItem(this.menu, this.title, this.icon);
}
