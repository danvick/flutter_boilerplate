import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'environments/.env')
abstract class Env {
  @EnviedField(varName: 'SERVER_URL', obfuscate: true)
  static const String serverUrl = _Env.serverUrl;
}
