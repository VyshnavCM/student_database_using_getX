// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_database_using_getx/controllers/student_controller.dart';
import 'package:student_database_using_getx/core/color/colors.dart';
import 'package:student_database_using_getx/core/constants/constants.dart';
import 'package:student_database_using_getx/models/student_model.dart';
import 'package:student_database_using_getx/presentation/home/home_screen.dart';

import '../../validator/student_form_validator.dart';

final TextEditingController _nameController = TextEditingController();
final TextEditingController _ageController = TextEditingController();
final TextEditingController _parentNameController = TextEditingController();
final TextEditingController _phoneNumberController = TextEditingController();

// // ignore: must_be_immutable
// class AddStudentScreen extends StatelessWidget {
//   final StudentsController _controller = Get.find<StudentsController>();

//   File? _image;

//   // New parameter to determine if it's in edit mode
//   final bool isEdit;

//   // Constructor
//   AddStudentScreen({super.key, this.isEdit = false}) {
//     if (isEdit) {
//       // Set initial values for editing
//       _nameController.text = 'Existing Name';
//       // Set other initial values as needed
//     }
//   }

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       _image = File(pickedImage.path);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kcardColor,
//       appBar: AppBar(
//         title: Text(isEdit ? 'Edit Student' : 'Add Student'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           // crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: CircleAvatar(
//                 radius: 48,
//                 child: _image != null
//                     ? CircleAvatar(
//                         radius: 30,
//                         backgroundImage: FileImage(_image!),
//                       )
//                     : Image.asset('assets/images/avatar.jpg'),
//               ),
//             ),
//             const Text('Name'),
//             TextField(controller: _nameController),
//             const SizedBox(height: 10),
//             const Text('Age'),
//             TextField(
//                 controller: _ageController, keyboardType: TextInputType.number),
//             const SizedBox(height: 10),
//             const Text('Parent Name'),
//             TextField(controller: _parentNameController),
//             const SizedBox(height: 10),
//             const Text('Phone Number'),
//             TextField(
//                 controller: _phoneNumberController,
//                 keyboardType: TextInputType.phone),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 ElevatedButton(
//                   onPressed: _pickImage,
//                   child: const Text('Pick Image'),
//                 ),
//                 const SizedBox(width: 10),
//                 _image != null
//                     ? CircleAvatar(
//                         radius: 30,
//                         backgroundImage: FileImage(_image!),
//                       )
//                     : Container(
//                         height: 20,
//                         width: 20,
//                         color: kButtonColor,
//                       ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 var newStudent = Student(
//                   name: _nameController.text,
//                   age: int.parse(_ageController.text),
//                   parentName: _parentNameController.text,
//                   phoneNumber: _phoneNumberController.text,
//                   photoPath: _image != null
//                       ? _image!.path
//                       : 'assets/images/default_photo.jpg',
//                 );

//                 if (isEdit) {
//                   // Handle editing logic here
//                   // Update the existing student in the database
//                   // Navigate back to the home screen
//                 } else {
//                   // Handle adding logic here
//                   _controller.addStudent(newStudent);
//                   Get.back(); // Navigate back to the home screen
//                 }
//               },
//               child: Text(isEdit ? 'Edit Student' : 'Add Student'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void textFieldClear() {
//   _parentNameController.clear();
//   _nameController.clear();
//   _ageController.clear();
//   _parentNameController.clear();
//   _phoneNumberController.clear();
// }

class AddStudentScreen extends StatelessWidget {
  final StudentsController _controller = Get.find();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _parentNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  File? _image;
  final formKey = GlobalKey<FormState>();
  AddStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcardColor,
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title:  Text('Add Student',style: kHeadingStyle,),
      ),
      body: _buildForm(),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Form(
            key: formKey,
            child: Column(
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
                        ),const SizedBox(width: 10,),
                        ElevatedButton(
                          
                      onPressed: _pickImage,
                      child: const Icon(Icons.add_a_photo,color: Colors.black,),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  
                  validator: (value) => nameValidator(value),
                  controller: _nameController,
                  decoration:const InputDecoration(
                    hintText: 'Enter students name',
                    // hintStyle: TextStyle(color: kGreyColor),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kMainTextColor)),
                      border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: kMainTextColor, width: 2)
                  ),
                ),),
                const SizedBox(height: 20),
                
                TextFormField(
                  validator: (value) => parentNameValidator(value),
                  controller: _parentNameController,
                   decoration:const InputDecoration(
                    hintText: 'Enter parents name'
                  ),
                ),
                const SizedBox(height: 20),
                
                TextFormField(
                  validator: (value) => ageValidator(value),
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                   decoration:const InputDecoration(
                    hintText: 'Enter students age'
                  ),
                ),
                const SizedBox(height: 20),
                
                TextFormField(
                  validator: (value) => mobileNumberValidator(value),
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                   decoration:const InputDecoration(
                    hintText: 'Enter phone number'
                  ),
                ),
                const SizedBox(height: 20),
                
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _addStudent,
                    child: const Text('Add Student'),
                  ),
                ),
              ],
            ),
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
      print("Picked Image Path: ${_image?.path}");
      Get.forceAppUpdate(); // Refresh the UI to show the picked image
    }
  }

  void _addStudent() async {
    var newStudent = Student(
      name: _nameController.text,
      age: int.parse(_ageController.text),
      parentName: _parentNameController.text,
      phoneNumber: _phoneNumberController.text,
      photoPath:
          _image != null ? _image!.path : 'assets/images/default_photo.jpg',
    );

    _controller.addStudent(newStudent);

    Get.to(HomeScreen()); // Navigate back to the home screen
  }
}
