import 'package:flutter/material.dart';
import 'package:segunda_prova/domain/cidade.dart';
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

class TelaHome extends StatefulWidget {
  @override
  _TelaHomeState createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  late DatabaseHelper databaseHelper;
  late Future<List<Cidade>> cidades;

  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper();
    cidades = databaseHelper.getAllCidades();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Cidades'),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              // Navegar para a tela de sobre
              Navigator.pushNamed(context, '/sobre');
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Cidade>>(
        future: cidades,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar os dados'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('Nenhuma cidade encontrada'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Cidade cidade = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    // Navegar para a tela de detalhes
                    Navigator.pushNamed(
                      context,
                      '/detalhes',
                      arguments: cidade.id,
                    );
                  },
                  onLongPress: () {
                    // Navegar para a tela de alteração
                    Navigator.pushNamed(
                      context,
                      '/altera',
                      arguments: cidade.id,
                    );
                  },
                  child: ListTile(
                    title: Text(cidade.nome),
                    subtitle: Text('População: ${cidade.populacao}'),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar para a tela de cadastro
          Navigator.pushNamed(context, '/cadastro');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
