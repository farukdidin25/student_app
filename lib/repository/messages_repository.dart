// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:akademi_student_app/models/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagesRepository extends ChangeNotifier{


  final List<Message> messages = [
    Message("Merhaba", "Ali", DateTime.now().subtract(const Duration(minutes: 3))),
    Message("Orada mısın", "Ali", DateTime.now().subtract(const Duration(minutes: 2))),
    Message("Evet", "Ayşe", DateTime.now().subtract(const Duration(minutes: 1))),
    Message("Nasılsın", "Ayşe", DateTime.now())
  ];

}

  final messsagesProvider = ChangeNotifierProvider((ref) => MessagesRepository());


  class NewMessageNumber extends StateNotifier<int>{
    NewMessageNumber(int state): super(state);
    void sifirla(){
      state = 0;
    }
  }

  final newMessageProvider = StateNotifierProvider<NewMessageNumber, int>((ref) => NewMessageNumber(4));