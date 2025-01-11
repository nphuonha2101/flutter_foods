import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static final String appName = dotenv.env['APP_NAME'] ?? '';
  static final double distanceHome = 99999;
    static final double distanceNearBy = 7000;
}
