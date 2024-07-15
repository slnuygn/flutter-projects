import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_app/repository/messages_repository.dart';

import '../models/message.dart';

class MessagesPage extends ConsumerStatefulWidget {
  const MessagesPage({super.key});

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends ConsumerState<MessagesPage> {

  @override
  void initState() {
    Future.delayed(Duration.zero).then(
      (value) => ref.read(newMessagesCountProvider.notifier).reset());
    ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final messagesRepository = ref.watch(messagesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messagesRepository.messages.length,
              itemBuilder: (context, index) {
                return MessageAppearance(
                    messagesRepository.messages[
                      messagesRepository.messages.length -index -1
                    ]
                );
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
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        )
                      ),
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      print('gönder');
                    },
                    child: Text('gönder'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );;
  }
}

class MessageAppearance extends StatelessWidget {
  final Message message;
  const MessageAppearance(this.message, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.sender == 'Elena' ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 2,),
            color: Colors.orange.shade100,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(message.text),
          ),
        ),
      ),
    );
  }
}
