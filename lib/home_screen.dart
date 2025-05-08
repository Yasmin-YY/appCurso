import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tela Principal")),
      body: Center(child: Text("Bem-vinda ao app!")),
    );
  }
}
