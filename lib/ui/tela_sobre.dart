// tela_sobre.dart

import 'package:flutter/material.dart';

class TelaSobre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Desenvolvedores:'),
            SizedBox(height: 16.0),
            Text('Felipe'),
            Text('Angela'),
          ],
        ),
      ),
    );
  }
}
