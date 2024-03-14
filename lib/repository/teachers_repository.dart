// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:akademi_student_app/models/teacher.dart';
import 'package:akademi_student_app/services/data_services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeachersRepository extends ChangeNotifier {
  List<Teacher> teachers = [
    Teacher("Faruk", "Çakar", 34, 'Erkek'),
    Teacher("Sude", "Parlar", 32, 'Kadın')
  ];
  
  final DataService dataService;
  TeachersRepository(this.dataService);

  Future<void> download() async {

    Teacher teacher = await dataService.teacherDownload();

    

    teachers.add(teacher);
    notifyListeners();
  }


  Future<List<Teacher>> allTake() async{
    teachers =  await dataService.teachersTake();
    return teachers;
    
  }

}

final teachersProvider = ChangeNotifierProvider((ref) {
  return TeachersRepository(ref.watch(dataServiceProvider));
});


final teacherListProvider = FutureProvider((ref) {
  return ref.watch(teachersProvider).allTake();
});