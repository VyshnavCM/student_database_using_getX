import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_database_using_getx/models/student_model.dart';
import 'package:student_database_using_getx/presentation/home/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async {
   await Hive.initFlutter();
  Hive.registerAdapter(StudentAdapter());
  await Hive.openBox('students');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
// 