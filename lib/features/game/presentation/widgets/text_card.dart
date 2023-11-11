import 'package:flutter/material.dart';

import '../../../../core/constants/enums.dart';
import '../../domain/entities/message_entity.dart';
import '../blocs/game_bloc.dart';

class TextCard extends StatelessWidget {
  final GameBloc gameBloc;
  final MessageEntity message;
  final bool shouldAnimate;

  const TextCard({
    super.key,
    required this.gameBloc,
    required this.message,
    required this.shouldAnimate,
  });

  Stream<int> _yieldCharacters() async* {
    final content = message.content;
    final initialIndex = shouldAnimate ? 0 : content.length;
    for (var i = initialIndex; i < content.length + 1; i++) {
      yield i;
      await Future<void>.delayed(const Duration(milliseconds: 50));
    }
    if (shouldAnimate) {
      gameBloc.add(const AnimationCompleteEvent());
    }
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
