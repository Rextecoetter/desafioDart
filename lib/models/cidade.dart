import 'dart:convert';

class Cidade {
  final int? id;
  final int idUf;
  final String nome;

  Cidade({required this.id, required this.idUf, required this.nome});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idUf': idUf,
      'nome': nome,
    };
  }

  factory Cidade.fromMap(Map<String, dynamic> map) {
    return Cidade(
      id: map['id']?.toInt(),
      idUf: map['idUf']?.toInt() ?? 0,
      nome: map['nome'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Cidade.fromJson(String source) => Cidade.fromMap(json.decode(source));

  @override
  String toString() => '''
    Cidade:
      ID Cidade: $id
      ID UF: $idUf
      Nome: $nome

  ''';
}
