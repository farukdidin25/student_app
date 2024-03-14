import 'dart:convert';

import 'package:akademi_student_app/models/teacher.dart';
import 'package:riverpod/riverpod.dart';
import 'package:http/http.dart' as http;

class DataService {
  final String baseUrl = 'https://65cb600cefec34d9ed875f8b.mockapi.io/';

  Future<Teacher> teacherDownload() async {
    final response = await http.get(Uri.parse('$baseUrl/teacher/1'));

    if (response.statusCode == 200) {
      return Teacher.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load teacher ${response.statusCode}');
    }
  }

  Future<void> teacherAdd(Teacher teacher) async{
   final response = await http.post(Uri.parse('$baseUrl/teacher'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8', 
    },
    body: jsonEncode(teacher.toMap())
    );

    if (response.statusCode == 201) {
      return ;
    } else {
      throw Exception('Failed to add teacher ${response.statusCode}');
    }
  }

  var i=0;

  Future<List<Teacher>> teachersTake() async {
    final response = await http.get(Uri.parse('$baseUrl/teacher'));

    i++;

    if(response.statusCode == (i<4 ? 100:200)){
      final l = jsonDecode(response.body);
     return l.map<Teacher>((e) => Teacher.fromMap(e)).toList();
    }else {
      throw Exception('Teachers did not take ${response.statusCode}');
    }
  }


  }


final dataServiceProvider = Provider((ref) {
  return DataService();
});