import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/student.dart';

class StudentsRepository extends ChangeNotifier{
  List<Student> students = [
    Student('Elena', 'Gilbert', 18, 'Female'),
    Student('Damon', 'Salvatore', 18, 'Male')
  ];

  final Set<Student> studentsILike= {};

  void like(Student student, bool doILikeThem){
    if(doILikeThem){
      studentsILike.add(student);
    } else {
      studentsILike.remove(student);
    }
    notifyListeners();
  }

  bool doILikeThem(Student student) {
    return studentsILike.contains(student);
  }

}

final studentsProvider = ChangeNotifierProvider((ref) {
  return StudentsRepository();
});

