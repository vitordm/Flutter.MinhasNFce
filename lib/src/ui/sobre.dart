import 'package:flutter/material.dart';

class Sobre extends StatelessWidget {
  const Sobre({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sobre"),
      ),
      body: Container(
          child: Center(child: Text("Desenvolvido por Vítor Oliveira!"))),
    );
  }
}
