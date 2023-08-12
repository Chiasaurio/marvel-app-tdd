import 'package:bia_flutter_test/features/characters/presentation/pages/characters_page.dart';
import 'package:flutter/material.dart';
import 'injection_container.dart' as di;

void main() async {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const Color color = Color(0xFF0b0c1e);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF0b0c1e, {
          50: color.withOpacity(.1),
          100: color.withOpacity(.2),
          200: color.withOpacity(.3),
          300: color.withOpacity(.4),
          400: color.withOpacity(.5),
          500: color.withOpacity(.6),
          600: color.withOpacity(.7),
          700: color.withOpacity(.8),
          800: color.withOpacity(.9),
          900: color.withOpacity(1),
        }),
      ),
      debugShowCheckedModeBanner: false,
      home: const CharactersPage(),
    );
  }
}
