import '../../../../core/constants/enums.dart';

class MessageEntity {
  final String id;
  final Role role;
  final String content;

  const MessageEntity({
    required this.id,
    required this.role,
    required this.content,
  });
}
