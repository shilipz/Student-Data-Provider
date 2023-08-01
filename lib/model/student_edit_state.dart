import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StudentEditState extends ChangeNotifier {
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _subjectController;
  late TextEditingController _phoneController;
  ImageProvider<Object>? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      // setState(() {
      //   _image = FileImage(
      //       File(pickedImage.path)); // Convert pickedImage to FileImage
      // });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _subjectController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
