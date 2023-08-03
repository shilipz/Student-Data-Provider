import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:student_management_app/screens/home_screen.dart';
import 'model/model.dart';
import 'student_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(StudentModelAdapter());
  // final _studentsBox = await Hive.openBox<StudentModel>('students');
  await StudentProvider().initHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StudentProvider(),
      child: const MaterialApp(
        title: 'Student Management App',
        home: StudentListScreen(),
      ),
    );
  }
}
