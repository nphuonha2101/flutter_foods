import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static final String baseUrl = dotenv.env['API_URL'] ?? '';
  static final String version = dotenv.env['API_VERSION'] ?? 'v1';
  static final num port = num.parse(dotenv.env['API_PORT'] ?? '8080');
  void main() {
}
}
