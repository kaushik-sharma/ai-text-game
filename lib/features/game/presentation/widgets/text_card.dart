import 'package:ai_text_game/features/game/domain/entities/message_entity.dart';
import 'package:ai_text_game/features/game/presentation/blocs/game_bloc.dart';
import 'package:flutter/material.dart';

class TextCard extends StatelessWidget {
  final MessageEntity message;
  final bool isFirst;

  const TextCard({
    Key? key,
    required this.message,
    required this.isFirst,
  }) : super(key: key);

  Stream<int> _yieldCharacters() async* {
    final content = message.content;
    final initialIndex = isFirst && shouldAnimate ? 0 : content.length;
    for (var i = initialIndex; i < content.length + 1; i++) {
      yield i;
      await Future<void>.delayed(const Duration(milliseconds: 60));
    }
    shouldAnimate = false;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: 0,
      stream: _yieldCharacters(),
      builder: (context, snapshot) => Text(
        message.content.substring(0, snapshot.data),
        textAlign: message.role == Role.user ? TextAlign.right : TextAlign.left,
        style: TextStyle(
          color: message.role == Role.user ? Colors.white60 : Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }
}
