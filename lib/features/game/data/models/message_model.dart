import 'dart:convert';

import '../../domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.role,
    required super.content,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessageModel &&
          runtimeType == other.runtimeType &&
          role == other.role &&
          content == other.content);

  @override
  int get hashCode => role.hashCode ^ content.hashCode;

  @override
  String toString() {
    return 'MessageModel{ role: $role, content: $content,}';
  }

  MessageModel copyWith({
    Role? role,
    String? content,
    String? id,
  }) {
    return MessageModel(
      role: role ?? this.role,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'author': role,
      'content': content,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    final message = map['message'] as Map<String, dynamic>;

    final Role role = Role.values.firstWhere(
      (role) => message['role'] as String == role.name,
    );

    return MessageModel(
      role: role,
      content: message['content'] as String,
    );
  }

  String toJson(Map<String, dynamic> map) {
    return jsonEncode(map);
  }

  factory MessageModel.fromJson(String source) {
    return MessageModel.fromMap(
      jsonDecode(source) as Map<String, dynamic>,
    );
  }
}
