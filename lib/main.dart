import 'package:flutter/material.dart';
import 'package:kyrylo_kaun_test_task/presentation/screens/launches_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'SpaceX client test task',
      home: LaunchesScreen(),
    );
  }
}
