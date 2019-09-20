import 'package:flutter/material.dart';

class SobrePage extends StatelessWidget {
  const SobrePage({Key key}) : super(key: key);

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
