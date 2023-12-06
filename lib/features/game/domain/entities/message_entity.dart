import '../../data/models/message_model.dart';

class MessageEntity {
  final Role role;
  final String content;

  const MessageEntity({
    required this.role,
    required this.content,
  });
}
