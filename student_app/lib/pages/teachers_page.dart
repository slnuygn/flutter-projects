import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_app/repository/teachers_repository.dart';

import '../models/teacher.dart';

class TeachersPage extends ConsumerWidget {
  const TeachersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teachersRepository = ref.watch(teachersProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Teachers')),
      body: Column(
        children: [
          PhysicalModel(
            color: Colors.white,
            elevation: 10,
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 32.0),
                    child: Text('${teachersRepository.teachers.length} Teachers'),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: DownloadTeacherButton(),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => TeacherList(
                teachersRepository.teachers[index],
              ),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: teachersRepository.teachers.length,
            ),
          ),
        ],
      ),
    );
  }
}

class DownloadTeacherButton extends StatefulWidget {
  const DownloadTeacherButton({
    super.key,
  });

  @override
  State<DownloadTeacherButton> createState() => _DownloadTeacherButtonState();
}

class _DownloadTeacherButtonState extends State<DownloadTeacherButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return isLoading ? const CircularProgressIndicator() : IconButton(
          icon: const Icon(Icons.download),
          onPressed: () async {
            //TODO loading
            //TODO error
            setState(() {
              isLoading = true;
            });
            await ref.read(teachersProvider).download();
            setState(() {
              isLoading = false;
            });

            try {
              setState(() {
                isLoading = true;
              });
              await ref.read(teachersProvider).download();
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.toString()),)
             );
            } finally {

              setState(() {
                isLoading = false;
              });
            }



          },
        );
      }
    );
  }
}

class TeacherList extends StatelessWidget {
  final Teacher teacher;
  const TeacherList(this.teacher, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(teacher.name + ' ' + teacher.surname),
      leading: IntrinsicWidth(child: Center(child: Text(teacher.gender == 'Female' ? '👩' : '👨'))),
      );
  }
}
