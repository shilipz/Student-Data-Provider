import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_app/model/model.dart';
import 'student_provider.dart';

class StudentEditScreen extends StatefulWidget {
  final StudentModel? student;

  StudentEditScreen({this.student});

  @override
  _StudentEditScreenState createState() => _StudentEditScreenState();
}

class _StudentEditScreenState extends State<StudentEditScreen> {
  late TextEditingController _nameController;
  late TextEditingController _ageController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.student?.name ?? '');
    _ageController =
        TextEditingController(text: widget.student?.age?.toString() ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.student == null ? 'Add Student' : 'Edit Student')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _saveStudent(context),
              child: Text('Save'),
            ),
            if (widget.student != null)
              ElevatedButton(
                onPressed: () => _deleteStudent(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text('Delete'),
              ),
          ],
        ),
      ),
    );
  }

  void _saveStudent(BuildContext context) async {
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);
    final name = _nameController.text;
    final age = int.tryParse(_ageController.text);

    if (name.isNotEmpty && age != null) {
      if (widget.student == null) {
        final newStudent = StudentModel(
            name: name, age: age, key: null, phone: '', subject: '');
        studentProvider.addStudent(newStudent);
      } else {
        final updatedStudent = StudentModel(
            name: name,
            age: age,
            subject: 'subject',
            phone: 'phone',
            key: 'key');
        studentProvider.updateStudent(updatedStudent);
      }
      Navigator.pop(context);
    }
  }

  void _deleteStudent(BuildContext context) {
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);
    studentProvider.deleteStudent(widget.student!);
    Navigator.pop(context);
  }
}
