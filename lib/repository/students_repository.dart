// ignore_for_file: non_constant_identifier_names

import 'package:akademi_student_app/models/student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class StudentsRepository extends ChangeNotifier {
  final students = [
    Student("Ali", "Çakar", 18, 'Erkek'),
    Student("Ayşe", "Parlar", 20, 'Kadın')
  ];

  final Set<Student> ILiked = {};

  void like(Student student, bool amILike) {
    if (amILike) {
      ILiked.add(student);
    } else {
      ILiked.remove(student);
    }
    notifyListeners();
  }

  bool amILike(Student student) {
    return ILiked.contains(student);
  }
}

final studentsProvider = ChangeNotifierProvider((ref) {
  return StudentsRepository();
});