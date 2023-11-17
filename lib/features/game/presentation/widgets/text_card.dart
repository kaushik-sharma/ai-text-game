import 'package:flutter/material.dart';

import '../../../../core/constants/enums.dart';
import '../../domain/entities/message_entity.dart';

class TextCard extends StatelessWidget {
  final MessageEntity message;
  final bool shouldAnimate;
  final VoidCallback onAnimComplete;

  const TextCard({
    super.key,
    required this.message,
    required this.shouldAnimate,
    required this.onAnimComplete,
  });

  Stream<int> _yieldCharacters() async* {
    final content = message.content;
    final initialIndex = shouldAnimate ? 0 : content.length;
    for (var i = initialIndex; i < content.length + 1; i++) {
      yield i;
      await Future<void>.delayed(const Duration(milliseconds: 50));
    }
    if (shouldAnimate) {
      onAnimComplete();
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
