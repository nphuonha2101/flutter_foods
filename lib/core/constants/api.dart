import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static final String baseUrl = dotenv.env['API_URL'] ?? '';
  static final String version = dotenv.env['API_VERSION'] ?? 'v1';
  static final num port = num.parse(dotenv.env['API_PORT'] ?? '8080');
  static final String apiUrl = '$baseUrl:$port/api/$version';
  static final String defaultImage =
      'https://cdn-icons-png.flaticon.com/512/1147/1147805.png';
}
