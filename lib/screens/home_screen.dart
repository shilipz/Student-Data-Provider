import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_app/model/model.dart';
import 'package:student_management_app/screens/add_screen.dart';
import 'package:student_management_app/screens/edit_screen.dart';

import '../student_provider.dart';

class StudentListScreen extends StatelessWidget {
  const StudentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);
    studentProvider.getallStudents();
    return Scaffold(
      appBar: AppBar(title: const Text('Student Data Provider')),
      body: Consumer<StudentProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.students.length,
            itemBuilder: (context, index) {
              final student = value.students[index];
              return GestureDetector(
                onTap: () {
                  return _navigateToEditScreen(
                      context,
                      student,
                      student.key,
                      student.age,
                      student.name,
                      student.subject,
                      student.phone);
                },
                child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/default_profile.png'),
                    ),
                    title: Text(student.name, style: TextStyle(fontSize: 20)),
                    subtitle: Text('Age: ${student.age}',
                        style: TextStyle(fontSize: 16)),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(children: [
                        IconButton(
                          color: Colors.green,
                          icon: const Icon(Icons.edit),
                          onPressed: () => _navigateToEditScreen(
                              context,
                              student,
                              student.key,
                              student.age,
                              student.name,
                              student.phone,
                              student.subject),
                        ),
                        IconButton(
                          color: Colors.red,
                          icon: const Icon(Icons.delete),
                          onPressed: () => value.deleteStudent(student),
                        ),
                      ]),
                    )),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddScreen(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

void _navigateToAddScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => StudentAddScreen()),
  );
}

void _navigateToEditScreen(BuildContext context, StudentModel student, int id,
    int age, String name, String phone, String subject) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => StudentEditScreen(
              age: age,
              name: name,
              phone: phone,
              subject: subject,
              student: student,
              id: id,
            )),
  );
}
