import 'dart:convert';

import 'package:http/http.dart';

void main() async {
  var url =
      'http://servicodados.ibge.gov.br/api/v1/localidades/estados/35/distritos';
  var result;
  try {
    result = await get(Uri.parse(url));
  } catch (e) {
    print('deu ruim');
  }

  if (result.statusCode == 200) {
    var cidades = jsonDecode(result.body);

    print(cidades['nome']);
  } else {
    print('nao foi possivel bla bla bla');
  }
}
