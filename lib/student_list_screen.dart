import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_app/model/model.dart';
import 'package:student_management_app/student_edit_screen.dart';
import 'student_provider.dart';

class StudentListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Student List')),
      body: ListView.builder(
        itemCount: studentProvider.students.length,
        itemBuilder: (context, index) {
          final student = studentProvider.students[index];
          return ListTile(
            title: Text(student.name),
            subtitle: Text('Age: ${student.age}'),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => _navigateToEditScreen(context, student),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddScreen(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _navigateToAddScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StudentEditScreen()),
    );
  }

  void _navigateToEditScreen(BuildContext context, StudentModel student) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => StudentEditScreen(student: student)),
    );
  }
}
