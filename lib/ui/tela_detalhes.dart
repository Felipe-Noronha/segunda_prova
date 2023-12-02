import 'package:flutter/material.dart';
import 'package:segunda_prova/domain/cidade.dart';
import 'package:segunda_prova/helpers/database_helper.dart';

class TelaDetalhes extends StatefulWidget {
  final int id;

  TelaDetalhes({required this.id});

  @override
  _TelaDetalhesState createState() => _TelaDetalhesState();
}

class _TelaDetalhesState extends State<TelaDetalhes> {
  Map<String, dynamic>? cidade;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    Map<String, dynamic>? cidadeCarregada =
        await DatabaseHelper().getCidadeById(widget.id);

    if (cidadeCarregada != null) {
      setState(() {
        cidade = cidadeCarregada;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Cidade'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: cidade != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nome: ${cidade?['nome']}'),
                  Text('Idioma: ${cidade?['idioma']}'),
                  Text('População: ${cidade?['populacao']}'),
                  Text('Área: ${cidade?['area']}'),
                  Text('Ano de Fundação: ${cidade?['anoFundacao']}'),
                  Text(
                      'Possui Aeroporto: ${cidade?['possuiAeroporto'] == 1 ? 'Sim' : 'Não'}'),
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
