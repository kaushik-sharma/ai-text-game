enum Role {
  user,
  assistant,
}

class MessageEntity {
  final Role role;
  final String content;

  const MessageEntity({
    required this.role,
    required this.content,
  });
}
