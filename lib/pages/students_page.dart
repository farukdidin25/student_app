// ignore_for_file: use_key_in_widget_constructors

import 'package:akademi_student_app/models/student.dart';
import 'package:akademi_student_app/repository/students_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentsPage extends ConsumerWidget {
  const StudentsPage({Key? key, required StudentsRepository studentsRepository, });

  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentsRepository = ref.watch(studentsProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Öğrenciler Sayfası'),
      ),
      body: Column(
        children: [
          PhysicalModel(
            color: Colors.white,
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 32.0),
              child: Center(
                child: Text(
                    '${studentsRepository.students.length} öğrenci'),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => StudentRow(
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

class StudentRow extends ConsumerWidget {
  final Student student;

  const StudentRow(
    this.student,
    {
    Key? key,
  }) : super(key: key);

  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool amILike = ref.watch(studentsProvider).amILike(student);
    return ListTile(
      title: Text("${student.ad} ${student.soyad}"),
      leading: IntrinsicWidth(
        child:
            Center(child: Text(student.cinsiyet == 'Kadın' ? '👩🏼' : '👱🏻')),
      ),
      trailing: IconButton(
        onPressed: () {
          ref.read(studentsProvider).like(student, !amILike);
          
        },
        icon: Icon(ref.watch(studentsProvider).amILike(student)
            ? Icons.favorite
            : Icons.favorite_border),
      ),
    );
  }
}