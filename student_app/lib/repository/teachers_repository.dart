import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_app/services/data_service.dart';

import '../models/teacher.dart';

class TeachersRepository extends ChangeNotifier{
  List<Teacher> teachers = [
    Teacher('Emine Elif', 'Tülay', 18, 'Female'),
    Teacher('Cihat', 'Çetinkaya', 18, 'Male')
  ];

  final DataService dataService;
  TeachersRepository(this.dataService);

  Future<void> download() async {
    Teacher teacher = await dataService.downloadTeacher();
    teachers.add(teacher);
    notifyListeners();
  }
}

final teachersProvider = ChangeNotifierProvider((ref) {
  return TeachersRepository(ref.watch(dataServiceProvider));
});

