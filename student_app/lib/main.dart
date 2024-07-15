import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_app/pages/messages_page.dart';
import 'package:student_app/pages/students_page.dart';
import 'package:student_app/pages/teachers_page.dart';
import 'package:student_app/repository/messages_repository.dart';
import 'package:student_app/repository/students_repository.dart';
import 'package:student_app/repository/teachers_repository.dart';

void main() {
  runApp(ProviderScope(child: const StudentApp()));
}

class StudentApp extends StatelessWidget {
  const StudentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainPage(title: 'Student Homepage'),
    );
  }
}

class MainPage extends ConsumerWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    StudentsRepository studentsRepository = ref.watch(studentsProvider);
    TeachersRepository teachersRepository = ref.watch(teachersProvider);
    void _goToStudents(BuildContext context) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return const StudentsPage();
        },
      ));
    }
    void _goToTeachers(BuildContext context) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return const TeachersPage();
        },
      ));
    }
    void _goToMessages(BuildContext context) async {
      await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return const MessagesPage();
        },
      ));
    }
    
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text(
                '${ref.watch(newMessagesCountProvider)} new messages',

              ),
              onPressed: () {
                _goToMessages(context);
                //sor(context);
              },
            ),
            ElevatedButton(
              child: Text(
                '${studentsRepository.students.length} students',

              ),
              onPressed: () {
                _goToStudents(context);
                //sor(context);
              },
            ),

            ElevatedButton(
              child: Text(
                '${teachersRepository.teachers.length} teachers',

              ),
              onPressed: () {
                _goToTeachers(context);
                //sor(context);
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Student Name'),
            ),
            ListTile(
              title: const Text('Students'),
              onTap: () {
                _goToStudents(context);
              },
            ),
            ListTile(
              title: const Text('Teachers'),
              onTap: () {
                _goToTeachers(context);
              },
            ),
            ListTile(
              title: const Text('Messages'),
              onTap: () {
                _goToMessages(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
