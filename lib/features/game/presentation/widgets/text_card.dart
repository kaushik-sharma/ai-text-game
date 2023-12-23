import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:typewritertext/typewritertext.dart';

import '../../data/models/message_model.dart';
import '../../domain/entities/message_entity.dart';

class TextCard extends StatelessWidget {
  final MessageEntity message;
  final bool play;
  final VoidCallback onAnimationComplete;

  const TextCard({
    super.key,
    required this.message,
    required this.play,
    required this.onAnimationComplete,
  });

  @override
  Widget build(BuildContext context) {
    onAnimationComplete();

    return TypeWriterText(
      key: UniqueKey(),
      maintainSize: false,
      play: play,
      text: Text(
        message.content,
        textAlign: message.role == Role.user ? TextAlign.right : TextAlign.left,
        style: TextStyle(
          color: message.role == Role.user ? Colors.white60 : Colors.white,
          fontSize: 14.sp,
        ),
      ),
      duration: const Duration(milliseconds: 50),
    );
  }
}
