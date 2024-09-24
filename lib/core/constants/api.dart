import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static final String baseUrl = dotenv.env['API_URL'] ?? '';
  static final num version = num.parse(dotenv.env['API_VERSION'] ?? '0');
  static final num port = num.parse(dotenv.env['API_PORT'] ?? '0');
}
