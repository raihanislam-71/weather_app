import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String apiKey = dotenv.env['API_KEY'] ?? '';
}