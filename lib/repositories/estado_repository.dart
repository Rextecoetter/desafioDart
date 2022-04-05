import 'dart:convert';
import 'package:desafio/models/estado.dart';
import 'package:desafio/repositories/database.dart';
import 'package:http/http.dart';

class EstadoRepository {
  Future<List<Estado>> pegarEstados() async {
    final url = 'https://servicodados.ibge.gov.br/api/v1/localidades/estados';
    var listaEstados = <Estado>[];
    final resposta = await get(Uri.parse(url));

    if (resposta.statusCode == 200) {
      var dados = jsonDecode(resposta.body);
      if (dados is List) {
        for (var estado in dados) {
          listaEstados.add(Estado.fromMap(estado));
        }
      }
    } else {
      print('Statuscode diferente de 200');
    }
    listaEstados[0].toString();
    return listaEstados;
  }

  Future<void> insertEstados(List<Estado> listaEstados) async {
    var dataBase = Database();
    var conn = await dataBase.openConnection();

    for (var estado in listaEstados) {
      try {
        await conn.query('insert into estado (id, uf, nome) values (?, ?, ?)',
            [estado.id, estado.uf, estado.nome]);
      } catch (e) {
        print('Erro ao inserir estados no banco de dados $e');
      }
    }
    conn.close();
  }

  Future<List<int>> pegarIdsEstados() async {
    var idsDosEstados = <int>[];
    var dataBase = Database();
    var conn = await dataBase.openConnection();

    {
      try {
        var resultadoSelect = await conn.query('select id from estado');
        resultadoSelect.forEach((id) {
          idsDosEstados.add(id['id']);
        });
      } on Exception catch (e) {
        print('Erro ao recuperar ids dos estados $e');
      }
    }

    conn.close();
    return idsDosEstados;
  }
}
