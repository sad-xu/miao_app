import 'package:flutter/material.dart';
import 'package:miao_app/pages/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // locale: const Locale('zh', 'CN'),
      // supportedLocales: const [
      //   Locale('zh', 'CN'),
      // ],
      home: const MyHomePage(),
    );
  }
}
