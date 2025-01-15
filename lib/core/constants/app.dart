import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static final String appName = dotenv.env['APP_NAME'] ?? '';
  static const double distanceHome = 99999;
  static const double distanceNearBy = 5;
}
