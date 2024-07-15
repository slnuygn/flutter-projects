import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/message.dart';

class MessagesRepository extends ChangeNotifier{
  final List<Message> messages = [
    Message('Hello', 'Elena', DateTime.now().subtract(const Duration(minutes: 3))),
    Message('Sup', 'Elena', DateTime.now().subtract(const Duration(minutes: 2))),
    Message('Hi', 'Damon', DateTime.now().subtract(const Duration(minutes: 1))),
    Message('I missed you', 'Damon', DateTime.now()),
  ];
}

final messagesProvider = ChangeNotifierProvider((ref) {
  return MessagesRepository();
});

class NewMessagesCount extends StateNotifier<int> {
  NewMessagesCount(int state) : super(state);

  void reset() {
   state = 0;
  }
}

final newMessagesCountProvider = StateNotifierProvider<NewMessagesCount, int>((ref) {
  return NewMessagesCount(4);
});

