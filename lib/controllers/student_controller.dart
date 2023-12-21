import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import '../models/student_model.dart';

class StudentsController extends GetxController {
  var students = <Student>[].obs;

 

  void addStudent(Student student) {
    students.add(student);
    updateDatabase();
  }

   void editStudent(Student oldStudent, Student newStudent) {
    var index = students.indexWhere((s) => s == oldStudent);
    if (index != -1) {
      students[index] = newStudent;
      updateDatabase();
    }
  }

  void updateDatabase() {
    var box = Hive.box('students');
    box.put('data', students.toList());
  }

  void deleteStudent(Student student) {
    students.remove(student);
    updateDatabase();
  }

   bool isStudentMatchSearch(Student student, String searchValue) {
    // Check if the student's name contains the search value (case-insensitive)
    return student.name.toLowerCase().contains(searchValue.toLowerCase());
  }

  List<Student> getFilteredStudents(String searchValue) {
    // Return a list of students that match the search value
    return students.where((student) => isStudentMatchSearch(student, searchValue)).toList();
  }
}