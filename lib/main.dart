// ignore_for_file: prefer_const_constructors

import 'package:akademi_student_app/pages/messages_page.dart';
import 'package:akademi_student_app/pages/students_page.dart';
import 'package:akademi_student_app/pages/teachers_page.dart';
import 'package:akademi_student_app/repository/messages_repository.dart';
import 'package:akademi_student_app/repository/students_repository.dart';
import 'package:akademi_student_app/repository/teachers_repository.dart';
import 'package:akademi_student_app/services/data_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child:  MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Öğrenci Uygulaması',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Öğrenci Ana Sayfa'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentsRepository = ref.watch(studentsProvider);
    final teachersRepository = ref.watch(teachersProvider);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(child: Text('${ref.watch(newMessageProvider)} yeni mesaj'),
            onPressed: () {
              _getMessages(context);
            },
            ),
            TextButton(child: Text('${studentsRepository.students.length} öğrenci'),
            onPressed: () {
              _getStudents(context);
            },
            ),
            TextButton(child: Text('${teachersRepository.teachers.length} öğretmen'),
            onPressed: (){
              _getTeachers(context);
            },
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue
              ),
              child: Text('Öğrenci Adı'),
            ),
            ListTile(
              title: const Text('Öğrenciler'),
              onTap: (){
                _getStudents(context);
              },
            ),
            ListTile(
              title: const Text('Öğretmenler'),
              onTap: (){
                _getTeachers(context);
              },
            ),
            ListTile(
              title: const Text('Mesajlar'),
              onTap: (){
                _getMessages(context);
              },
            ),
            
          ],
        ),
      ),
    );
  }

  void _getStudents(BuildContext context,){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return  StudentsPage(studentsRepository: StudentsRepository(),);
    }));
  }

 void _getTeachers(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return  TeachersPage(teachersRepository: TeachersRepository(DataService()),);
    }));
  }

  Future<void> _getMessages(BuildContext context) async{
    await Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return  MessagesPage(messagesRepository: MessagesRepository(),);
    }));
  }

}