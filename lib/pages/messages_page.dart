
// ignore_for_file: library_private_types_in_public_api

import 'package:akademi_student_app/models/message.dart';
import 'package:akademi_student_app/repository/messages_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagesPage extends ConsumerStatefulWidget {
  const MessagesPage({super.key, required MessagesRepository messagesRepository, });

  @override
  _MessagesPageState createState() => _MessagesPageState();
  }

class _MessagesPageState extends ConsumerState<MessagesPage> {

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) => ref.read(newMessageProvider.notifier).sifirla());
    
    //widget.messagesRepository.newMessage = 0;
    super.initState();
    
  }


  @override
  Widget build(BuildContext context) {
    final messagesRepository = ref.watch(messsagesProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Mesajlar Sayfası'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messagesRepository.messages.length,
              itemBuilder: (context, index) {
                return MessageScreen(messagesRepository.messages[messagesRepository.messages.length - index - 1 ]);
              },
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: Row(
              children: [
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: const BorderRadius.all(Radius.circular(25))),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none
                              ),
                            ),
                          )),
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: ElevatedButton(
                      onPressed: () {
                        if (kDebugMode) {
                          print('Gönder');
                        }
                      },
                      child: const Text('Gönder')),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MessageScreen extends StatelessWidget {
  final Message message;
  const MessageScreen(this.message, {
    super.key, 
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          message.sender == 'Ali' ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 8.0, vertical: 16.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 2),
              color: Colors.orange.shade100,
              borderRadius:
                  const BorderRadius.all(Radius.circular(15))),
          child:  Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(message.text),
          ),
        ),
      ),
    );
  }
}