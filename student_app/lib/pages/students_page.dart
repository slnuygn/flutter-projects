import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_app/repository/students_repository.dart';

import '../models/student.dart';

class StudentsPage extends ConsumerWidget {
  const StudentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentsRepository = ref.watch(studentsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Students')),
      body: Column(
        children: [
          PhysicalModel(
            color: Colors.white,
            elevation: 10,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 32.0),
                child: Text('${studentsRepository.students.length} Students'),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => StudentList(
                  studentsRepository.students[index],
                ),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: studentsRepository.students.length,
            ),
          ),
        ],
      ),
    );
  }
}

class StudentList extends ConsumerWidget {
  final Student student;
  const StudentList(this.student, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool doILikeThem = ref.watch(studentsProvider).doILikeThem(student);
    return ListTile(
      title: Text(student.name + ' ' + student.surname),
      leading: IntrinsicWidth(child: Center(child: Text(student.gender == 'Female' ? '👩' : '👨'))),
      trailing: IconButton(
          onPressed: () {
            ref.read(studentsProvider).like(student, !doILikeThem);
          },
          icon: Icon(doILikeThem ? Icons.favorite : Icons.favorite_border),
      ),
    );
  }
}
