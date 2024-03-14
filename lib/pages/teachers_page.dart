// ignore_for_file: use_build_context_synchronously, unused_result

import 'package:akademi_student_app/models/teacher.dart';
import 'package:akademi_student_app/pages/teacher/teacher_form.dart';
import 'package:akademi_student_app/repository/teachers_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeachersPage extends ConsumerWidget {
  const TeachersPage({
    super.key,
    required TeachersRepository teachersRepository,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teachersRepository = ref.watch(teachersProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Öğretmenler Sayfası'),
      ),
      body: Column(
        children: [
          PhysicalModel(
            color: Colors.white,
            elevation: 10,
            child: Stack(children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 32.0, horizontal: 32.0),
                  child: Center(
                      child: Text(
                          '${teachersRepository.teachers.length} öğretmen')),
                ),
              ),
              const Align(
                  alignment: Alignment.centerRight,
                  child: TeacherDownloadWidget())
            ]),
          ),
          Expanded(
              child: RefreshIndicator(
            onRefresh: () async {
              ref.refresh(teacherListProvider);
            },
            child: ref.watch(teacherListProvider).when(
                data: (data) => ListView.separated(
                      itemBuilder: (context, index) => TeacherRow(
                        data[index],
                      ),
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: data.length,
                    ),
                error: (
                  error,
                  stackTrace,
                ) {
                  return const SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Text('error'),
                  );
                },
                loading: () {
                  return const Center(child: CircularProgressIndicator());
                }),
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final created = await Navigator.of(context)
              .push<bool>(MaterialPageRoute(builder: (context) {
            return const TeacherForm();
          }));
          if (created == true) {
            if (kDebugMode) {
              print('Refresh Teacher');
            }
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TeacherDownloadWidget extends StatefulWidget {
  const TeacherDownloadWidget({
    super.key,
  });

  @override
  State<TeacherDownloadWidget> createState() => _TeacherDownloadWidgetState();
}

class _TeacherDownloadWidgetState extends State<TeacherDownloadWidget> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return isLoading
          ? const CircularProgressIndicator()
          : IconButton(
              icon: const Icon(Icons.download),
              onPressed: () async {
                try {
                  setState(() {
                    isLoading = true;
                  });

                  await ref.read(teachersProvider).download();
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                } finally {
                  setState(() {
                    isLoading = false;
                  });
                }
              });
    });
  }
}

class TeacherRow extends StatelessWidget {
  final Teacher teacher;

  const TeacherRow(
    this.teacher, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${teacher.ad} ${teacher.soyad}"),
      leading: IntrinsicWidth(
        child:
            Center(child: Text(teacher.cinsiyet == 'Kadın' ? '👩🏼' : '👱🏻')),
      ),
    );
  }
}
