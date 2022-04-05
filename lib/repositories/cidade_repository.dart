import 'dart:convert';

import 'package:desafio/models/cidade.dart';
import 'package:desafio/repositories/database.dart';
import 'package:http/http.dart';
import 'package:mysql1/mysql1.dart';

class CidadeRepository {
  //servicodados.ibge.gov.br/api/v1/localidades/estados/35/distritos

  Future<List<Cidade>> pegarCidades(List<int> idsDosEstados) async {
    var todasAsCidades = <Cidade>[];

    for (var idEstado in idsDosEstados) {
      var url =
          'https://servicodados.ibge.gov.br/api/v1/localidades/estados/$idEstado/distritos';
      final httpResult = await get(Uri.parse(url));

      if (httpResult.statusCode == 200) {
        var dados = jsonDecode(httpResult.body);
        if (dados is List) {
          for (var cidade in dados) {
            var city = Cidade(
              id: int.parse(cidade['id']),
              idUf: idEstado,
              nome: cidade['nome'],
            );
            todasAsCidades.add(city);
          }
        }
      } else {
        print('Problema ao recuperar as cidades de um estado');
      }
    }
    return todasAsCidades;
  }

  Future<void> insertCidades(List<Cidade> todasAsCidades) async {
    Database database = Database();

    MySqlConnection conn = await database.openConnection();

    for (var cidade in todasAsCidades) {
      try {
        await conn
            .query('insert into cidade (id, id_uf, nome) values (?, ?, ?)', [
          cidade.id,
          cidade.idUf,
          cidade.nome,
        ]);
      } catch (e) {
        print('Não foi possivel inserir cidade na tabela');
      }
    }

    conn.close();
  }
}
