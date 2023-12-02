import 'package:flutter/material.dart';
import 'package:segunda_prova/domain/cidade.dart';
import 'package:segunda_prova/helpers/database_helper.dart';
import 'tela_cadastro.dart';
import 'tela_detalhes.dart';
import 'tela_altera.dart';

void main() {
  runApp(SegundaProvaApp());
}

class SegundaProvaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TelaHome(),
      routes: {
        '/cadastro': (context) => TelaCadastro(),
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
                    // Navegar para a tela de detalhes com o ID
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaDetalhes(id: cidade.id!),
                      ),
                    );
                  },
                  onLongPress: () {
                    // Navegar para a tela de alteração com o ID
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaAltera(id: cidade.id!),
                      ),
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
