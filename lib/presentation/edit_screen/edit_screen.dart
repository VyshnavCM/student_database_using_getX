// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_database_using_getx/core/color/colors.dart';
import 'package:student_database_using_getx/core/constants/constants.dart';
import 'package:student_database_using_getx/presentation/home/home_screen.dart';

import '../../controllers/student_controller.dart';
import '../../models/student_model.dart';

class EditStudentScreen extends StatelessWidget {
  final StudentsController _controller = Get.find();
  final Student student;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _parentNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  File? _image;

  EditStudentScreen({super.key, required this.student}) {
    _nameController.text = student.name;
    _ageController.text = student.age.toString();
    _parentNameController.text = student.parentName;
    _phoneNumberController.text = student.phoneNumber;
    _image = File(student.photoPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcardColor,
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: Row(
          children: [
            kWidth30,
            kWidth10,
            Text(
              ' Student Details',
              style: kHeadingStyle,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: kWhiteColor,
            ),
            onPressed: _showDeleteConfirmationDialog,
          ),
        ],
      ),
      body: _buildForm(),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(width: 20),
                  _image != null
                      ? CircleAvatar(
                          radius: 70,
                          backgroundImage: FileImage(_image!),
                        )
                      : Container(
                          height: 100,
                          width: 100,
                          color: kWhiteColor,
                          child: Image.asset('assets/images/default_photo.jpg'),
                        ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: const Icon(
                      Icons.add_a_photo,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text('Name'),
              TextField(controller: _nameController),
              const SizedBox(height: 10),
              const Text('Age'),
              TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 10),
              const Text('Parent Name'),
              TextField(controller: _parentNameController),
              const SizedBox(height: 10),
              const Text('Phone Number'),
              TextField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: _editStudent,
                  child: const Text('Save Changes'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      _image = File(pickedImage.path);
      Get.forceAppUpdate(); // Refresh the UI to show the picked image
    }
  }

  void _editStudent() {
    var editedStudent = Student(
      name: _nameController.text,
      age: int.parse(_ageController.text),
      parentName: _parentNameController.text,
      phoneNumber: _phoneNumberController.text,
      photoPath: _image != null ? _image!.path : 'assets/default_photo.png',
    );

    _controller.editStudent(student, editedStudent);
    Get.back(); // Navigate back to the home screen
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: const Text('Delete Student'),
        content: const Text('Are you sure you want to delete this student?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _controller.deleteStudent(student);
              Get.to(
                  HomeScreen()); // Navigate back to the home screen after deletion
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
