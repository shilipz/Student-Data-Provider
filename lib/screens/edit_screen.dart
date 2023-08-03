import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_management_app/model/model.dart';

import '../student_provider.dart';

class StudentEditScreen extends StatelessWidget {
  final StudentModel? student;
  int id;
  String name;
  int age;
  String subject;
  String phone;

  StudentEditScreen(
      {super.key,
      this.student,
      required this.id,
      required this.name,
      required this.age,
      required this.subject,
      required this.phone});

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _ageController = TextEditingController();

  final TextEditingController _subjectController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();
  ImageProvider<Object>? _image;

  // @override
  @override
  Widget build(BuildContext context) {
    _nameController.text = name;
    _ageController.text = age.toString();
    _subjectController.text = subject;
    _phoneController.text = phone;

    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text('Edit Student')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildProfileImage(),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _subjectController,
                decoration: const InputDecoration(labelText: 'Subject'),
              ),
              const SizedBox(height: 16),
              TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _saveEditStudent(context);
                  studentProvider.getallStudents();
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
              if (student != null)
                ElevatedButton(
                  onPressed: () => _deleteStudent(context),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Delete'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return GestureDetector(
      onTap: _pickImage,
      child: CircleAvatar(
        radius: 50,
        child: SizedBox.fromSize(
          child: ClipOval(
              child: _image != null
                  ? Image.file(File(_image.toString()))
                  : Image.asset(
                      'assets/default_profile.png',
                      fit: BoxFit.cover,
                    )),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      //   setState(() {
      //     _image = FileImage(
      //         File(pickedImage.path)); // Convert pickedImage to FileImage
      //   });
    }
  }

  void _saveEditStudent(BuildContext context) async {
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);
    final name = _nameController.text;
    final age = int.tryParse(_ageController.text);
    final subject = _subjectController.text;
    final phone = _phoneController.text;
    if (name.isEmpty || age == null || subject.isEmpty || phone.isEmpty) {
      // Show an error message using SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All fields are required.'),
          duration: Duration(seconds: 2),
        ),
      );
      return; // Stop further execution if any field is empty
    }

    // if (widget.student == null) {
    //   final newStudent = StudentModel(
    //       name: name,
    //       age: age,
    //       id: DateTime.now().millisecondsSinceEpoch,
    //       phone: phone,
    //       subject: subject);
    //   studentProvider.addStudent(newStudent);
    // } else {
    final updatedStudent = StudentModel(
        name: name, age: age, id: student!.key, phone: phone, subject: subject);
    studentProvider.editStudent(id, updatedStudent);
    // }
  }

  void _deleteStudent(BuildContext context) {
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);
    studentProvider.deleteStudent(student!);
    Navigator.pop(context);
  }
}
