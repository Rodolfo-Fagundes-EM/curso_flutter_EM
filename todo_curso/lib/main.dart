import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_curso/presentation/screens/home_screen.dart';

void main() async {
  await Hive.initFlutter('hive');
  runApp(const MaterialApp(
    home: HomeScreen(),
  ));
}
