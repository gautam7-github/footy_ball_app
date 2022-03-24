import 'package:footy/src/views/home_page.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(
    const FootyApp(),
  );
}

class FootyApp extends StatelessWidget {
  const FootyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Footy Ball",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
