import 'package:flutter/material.dart';
import 'package:segunda_prova/helpers/database_helper.dart';
import 'package:segunda_prova/domain/cidade.dart';
import 'package:segunda_prova/ui/tela_home.dart';

class TelaAltera extends StatefulWidget {
  final int id;

  TelaAltera({required this.id});

  @override
  _TelaAlteraState createState() => _TelaAlteraState();
}

class _TelaAlteraState extends State<TelaAltera> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idiomaController = TextEditingController();
  final TextEditingController _populacaoController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _anoFundacaoController = TextEditingController();
  bool _possuiAeroporto = false;

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
      cidade = cidadeCarregada;

      _nomeController.text = cidade?['nome'] ?? '';
      _idiomaController.text = cidade?['idioma'] ?? '';
      _populacaoController.text = cidade?['populacao']?.toString() ?? '';
      _areaController.text = cidade?['area']?.toString() ?? '';
      _anoFundacaoController.text = cidade?['anoFundacao']?.toString() ?? '';
      _possuiAeroporto = cidade?['possuiAeroporto'] == 1;

      setState(() {});
    }
  }

  Future<void> _alterarCidade(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      DatabaseHelperCidade cidadeAtualizada = DatabaseHelperCidade(
        id: widget.id,
        nome: _nomeController.text,
        idioma: _idiomaController.text,
        populacao: int.tryParse(_populacaoController.text) ?? 0,
        area: double.tryParse(_areaController.text) ?? 0.0,
        anoFundacao: int.tryParse(_anoFundacaoController.text) ?? 0,
        possuiAeroporto: _possuiAeroporto,
      );

      await DatabaseHelper().updateCidade(cidadeAtualizada.toMap());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Alteração realizada com sucesso!'),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TelaHome()),
      );
    }
  }

  Future<void> _excluirCidade(BuildContext context) async {
    await DatabaseHelper().deleteCidade(widget.id);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Cidade excluída com sucesso!'),
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => TelaHome()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alterar Cidade'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              bool confirmado = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirmar Exclusão'),
                    content:
                        Text('Tem certeza de que deseja excluir esta cidade?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text('Confirmar'),
                      ),
                    ],
                  );
                },
              );

              if (confirmado == true) {
                await _excluirCidade(context);
              }
            },
          ),
        ],
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
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _idiomaController,
                decoration: InputDecoration(labelText: 'Idioma'),
                // Validator e outros atributos conforme necessário
              ),
              TextFormField(
                controller: _populacaoController,
                decoration: InputDecoration(labelText: 'População'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _areaController,
                decoration: InputDecoration(labelText: 'Área'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _anoFundacaoController,
                decoration: InputDecoration(labelText: 'Ano de Fundação'),
                keyboardType: TextInputType.number,
              ),
              Row(
                children: [
                  Checkbox(
                    value: _possuiAeroporto,
                    onChanged: (value) {
                      setState(() {
                        _possuiAeroporto = value ?? false;
                      });
                    },
                  ),
                  Text('Possui Aeroporto'),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  await _alterarCidade(context);
                },
                child: Text('Confirmar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
