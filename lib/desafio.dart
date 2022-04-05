import 'package:desafio/models/cidade.dart';
import 'package:desafio/models/estado.dart';
import 'package:desafio/repositories/cidade_repository.dart';
import 'package:desafio/repositories/estado_repository.dart';

void main() async {
  var estadoRepository = EstadoRepository();
  var cidadeRepository = CidadeRepository();
  List<Estado> estado = await estadoRepository.pegarEstados();
  estadoRepository.insertEstados(estado);
  List<int> idsDosEstados = await estadoRepository.pegarIdsEstados();
  List<Cidade> todasAsCidades =
      await cidadeRepository.pegarCidades(idsDosEstados);
  cidadeRepository.insertCidades(todasAsCidades);
  print('fim');
}
