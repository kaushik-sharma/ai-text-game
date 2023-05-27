import 'dart:convert';

import 'package:ai_text_game/features/game/domain/entities/message_entity.dart';
import 'package:ai_text_game/features/game/presentation/blocs/game_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextCard extends StatefulWidget {
  final MessageEntity message;
  final bool isLast;

  const TextCard({
    Key? key,
    required this.message,
    required this.isLast,
  }) : super(key: key);

  @override
  State<TextCard> createState() => _TextCardState();
}

class _TextCardState extends State<TextCard> {
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    if (widget.isLast && shouldAnimate) {
      _speak();
    }
  }

  Stream<int> _yieldCharacter() async* {
    final content = widget.message.content;
    final initialIndex = widget.isLast && shouldAnimate ? 0 : content.length;
    for (var i = initialIndex; i < content.length + 1; i++) {
      yield i;
      await Future<void>.delayed(const Duration(milliseconds: 60));
    }
    shouldAnimate = false;
  }

  Future<void> _speak() async {
    // await _flutterTts.setSpeechRate(1.5);
    await _flutterTts
        .setVoice({"name": "en-us-x-iol-local", "locale": "en-US"});

    // print();
    final formattedJson = const JsonEncoder.withIndent('  ')
        .convert(await _flutterTts.getDefaultVoice);
    debugPrint(formattedJson);
    await _flutterTts.speak(widget.message.content);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: 0,
      stream: _yieldCharacter(),
      builder: (context, snapshot) => Text(
        widget.message.content.substring(0, snapshot.data),
        style: TextStyle(
          color:
              widget.message.role == Role.user ? Colors.white38 : Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }
}
