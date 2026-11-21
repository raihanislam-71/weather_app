import 'package:material_ui/material_ui.dart';
import 'package:weather_app/screens/home_screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: const HomeScreen(),
    );
  }
}

