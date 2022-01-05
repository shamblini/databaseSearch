import 'package:mysql1/mysql1.dart';

class Mysql {
  static String host =
      'aws-medicare.csyojtxzb7ze.us-east-2.rds.amazonaws.com'; //Using 10.0.2.2 instead of localhost bc running on Android emulator
  static String user = 'admin';
  static String password = 'mediCARE21!';
  static String db = 'providers';

  static int port = 3306;

  Mysql();

  Future<MySqlConnection> getConnection() async {
    var settings = new ConnectionSettings(
        host: host, port: port, user: user, password: password, db: db);
    return await MySqlConnection.connect(settings);
  }
}
