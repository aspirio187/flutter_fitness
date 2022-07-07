import 'package:flutter/material.dart';
import 'package:flutter_fitness/sql_helper.dart';
import 'package:flutter_fitness/uis/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SqlHelper.db().then((database) {
      SqlHelper.createTables(database);
    });

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
