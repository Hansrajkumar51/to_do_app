import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/pages/home_page.dart';

void main() async {
  //initailize the hive
  await Hive.initFlutter();

  //open the box
  var box = await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TO DO',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const HomePage(),
    );
  }
}
