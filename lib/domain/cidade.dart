class Cidade {
  int? id;
  final String nome;
  final String idioma;
  final int populacao;
  final double area;
  final int anoFundacao;
  final bool possuiAeroporto;

  Cidade({
    this.id,
    required this.nome,
    required this.idioma,
    required this.populacao,
    required this.area,
    required this.anoFundacao,
    required this.possuiAeroporto,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'idioma': idioma,
      'populacao': populacao,
      'area': area,
      'anoFundacao': anoFundacao,
      'possuiAeroporto': possuiAeroporto ? 1 : 0,
    };
  }

  factory Cidade.fromMap(Map<String, dynamic> map) {
    return Cidade(
      id: map['id'],
      nome: map['nome'],
      idioma: map['idioma'],
      populacao: map['populacao'],
      area: map['area'],
      anoFundacao: map['anoFundacao'],
      possuiAeroporto: map['possuiAeroporto'] == 1 ? true : false,
    );
  }
}

class DatabaseHelperCidade {
  int? id;
  String nome;
  String idioma;
  int populacao;
  double area;
  int anoFundacao;
  bool possuiAeroporto;

  DatabaseHelperCidade({
    this.id,
    required this.nome,
    required this.idioma,
    required this.populacao,
    required this.area,
    required this.anoFundacao,
    required this.possuiAeroporto,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'idioma': idioma,
      'populacao': populacao,
      'area': area,
      'anoFundacao': anoFundacao,
      'possuiAeroporto': possuiAeroporto ? 1 : 0,
    };
  }

  factory DatabaseHelperCidade.fromMap(Map<String, dynamic> map) {
    return DatabaseHelperCidade(
      id: map['id'],
      nome: map['nome'],
      idioma: map['idioma'],
      populacao: map['populacao'],
      area: map['area'],
      anoFundacao: map['anoFundacao'],
      possuiAeroporto: map['possuiAeroporto'] == 1 ? true : false,
    );
  }
}
