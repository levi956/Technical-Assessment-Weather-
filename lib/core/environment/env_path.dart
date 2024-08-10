import 'package:envied/envied.dart';

part 'env_path.g.dart';

// Retrieving the API-KEY from an environmental path
// Demonstrating security for SECRET KEYS
@Envied(
  path: '.env',
  obfuscate: true,
)
abstract class EnvPath {
  @EnviedField(varName: 'API_KEY')
  static String apiKey = _EnvPath.apiKey;
}
