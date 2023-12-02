import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';
import 'tela_home.dart';

class TelaCadastro extends StatefulWidget {
  @override
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idiomaController = TextEditingController();
  final TextEditingController _populacaoController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _anoFundacaoController = TextEditingController();
  bool _possuiAeroporto = false;

  void _cadastrarCidade(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      Map<String, dynamic> novaCidade = {
        'nome': _nomeController.text,
        'idioma': _idiomaController.text,
        'populacao': int.parse(_populacaoController.text),
        'area': double.parse(_areaController.text),
        'anoFundacao': int.parse(_anoFundacaoController.text),
        'possuiAeroporto': _possuiAeroporto ? 1 : 0,
      };

      DatabaseHelper databaseHelper = DatabaseHelper();
      databaseHelper.insertCidade(novaCidade);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cadastro realizado com sucesso!'),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TelaHome()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Cidade'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _idiomaController,
                decoration: InputDecoration(labelText: 'Idioma'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _populacaoController,
                decoration: InputDecoration(labelText: 'População'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _areaController,
                decoration: InputDecoration(labelText: 'Área'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _anoFundacaoController,
                decoration: InputDecoration(labelText: 'Ano de Fundação'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Text('Possui Aeroporto: '),
                  Checkbox(
                    value: _possuiAeroporto,
                    onChanged: (value) {
                      setState(() {
                        _possuiAeroporto = value ?? false;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _cadastrarCidade(context);
                },
                child: Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
