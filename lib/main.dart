import 'package:flutter/material.dart';
import 'package:segunda_prova/domain/cidade.dart';
import 'package:segunda_prova/ui/tela_home.dart';
import 'helpers/database_helper.dart';
import 'ui/tela_sobre.dart';
import 'ui/tela_cadastro.dart';
import 'ui/tela_altera.dart';
import 'ui/tela_detalhes.dart';

void main() {
  runApp(SegundaProvaApp());
}

class SegundaProvaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w300,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          labelLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      initialRoute: '/home',
      onGenerateRoute: (settings) {
        if (settings.name == '/cadastro') {
          return MaterialPageRoute(builder: (context) => TelaCadastro());
        } else if (settings.name == '/sobre') {
          return MaterialPageRoute(builder: (context) => TelaSobre());
        } else if (settings.name == '/altera') {
          final args = settings.arguments;
          if (args is int) {
            return MaterialPageRoute(
                builder: (context) => TelaAltera(id: args));
          }
        } else if (settings.name == '/detalhes') {
          final args = settings.arguments;
          if (args is int) {
            return MaterialPageRoute(
                builder: (context) => TelaDetalhes(id: args));
          }
        }

        return MaterialPageRoute(builder: (context) => TelaHome());
      },
    );
  }
}
