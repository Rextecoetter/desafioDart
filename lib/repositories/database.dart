import 'package:mysql1/mysql1.dart';

class Database {
  Future<MySqlConnection> openConnection() {
    final settings = ConnectionSettings(
      host: 'SEU_IP_AQUI',
      port: 3306,
      user: 'SEU_USER_AQUI',
      password: 'SUA_SENHA_AQUI',
      db: 'NOME_DO_BANCO',
    );
    return MySqlConnection.connect(settings);
  }
}
