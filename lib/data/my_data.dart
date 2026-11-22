import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get apiKey => dotenv.env['API_KEY'] ?? '';
}