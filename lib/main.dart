import 'package:flutter/material.dart';
import 'package:flutter_1/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // initialize the hive
  await Hive.initFlutter();

  // open a box
  // ignore: unused_local_variable
  var box = await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: HomePage());
  }
}
