import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_database_using_getx/controllers/student_controller.dart';
import 'package:student_database_using_getx/core/color/colors.dart';
import 'package:student_database_using_getx/core/constants/constants.dart';
import 'package:student_database_using_getx/presentation/edit_screen/edit_screen.dart';
import '../../models/student_model.dart';
import '../add_screen/add_screen.dart';


class HomeScreen extends StatelessWidget {
  final StudentsController _controller = Get.put(StudentsController());
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcardColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kAppBarColor,
        title: Center(
          child: Text(
            'Students',
            style: kHeadingStyle,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(
                () {
                  List<Student> filteredStudents =
                      _controller.getFilteredStudents(_searchController.text);

                  return ListView.builder(
                    itemCount: filteredStudents.length,
                    itemBuilder: (context, index) {
                      var student = filteredStudents[index];
                      return Card(
                        child: ListTile(
                          title: Text(student.name),
                          subtitle: Text('Age: ${student.age}'),
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(student.photoPath),
                          ),
                          onTap: () {
                            // Navigate to the EditStudentScreen in edit mode
                            Get.to(EditStudentScreen(student: student));
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kButtonColor,
        onPressed: () {
          // Navigate to the AddStudentScreen in add mode
          Get.to(AddStudentScreen());
        },
        child: const Icon(Icons.add, color: kWhiteColor),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(

      controller: _searchController,
      decoration:const InputDecoration(
        hintText: 'Search students...',
        prefixIcon: Icon(Icons.search),
        filled: true,
        fillColor: kWhiteColor

      ),
      onChanged: (_) {
        // Refresh the UI when the search text changes
        Get.forceAppUpdate();
      },
    );
  }
}

