import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_management_app/model/model.dart';

class StudentProvider extends ChangeNotifier {
  late Box<StudentModel> _studentsBox;
  List<StudentModel> _students = [];

  StudentProvider() {
    initHive();
  }

  Future<void> initHive() async {
    // await Hive.initFlutter();
    _studentsBox = await Hive.openBox<StudentModel>('students');
    _students = _studentsBox.values.toList();
    notifyListeners();
  }

  List<StudentModel> get students => _students;

  Future<void> addStudent(StudentModel student) async {
    await _studentsBox.add(student);
    log(_studentsBox.values.length.toString());
    _students.add(student);
    notifyListeners();
  }

  Future<void> updateStudent(StudentModel student) async {
    await student.save();
    int index = _students.indexWhere((s) => s.key == student.key);
    if (index >= 0) {
      _students[index] = student;
      notifyListeners();
    }
  }

  Future<void> deleteStudent(StudentModel student) async {
    await student.delete();
    _students.removeWhere((s) => s.key == student.key);
    notifyListeners();
  }
}
