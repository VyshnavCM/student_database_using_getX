import 'package:hive/hive.dart';
part 'student_model.g.dart';

@HiveType(typeId: 1)

class Student extends HiveObject {
   @HiveField(0)
   String name;

   @HiveField(1)
   int age;
   @HiveField(2)
   String parentName;

   @HiveField(3)
   String phoneNumber;

   @HiveField(4)
   String photoPath;

  Student({
    required this.name,
    required this.age,
    required this.parentName,
    required this.phoneNumber,
    required this.photoPath,
  });
}