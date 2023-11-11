import 'dart:convert';

import '../../../../core/constants/enums.dart';
import '../../domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.id,
    required super.role,
    required super.content,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessageModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          role == other.role &&
          content == other.content);

  @override
  int get hashCode => id.hashCode ^ role.hashCode ^ content.hashCode;

  @override
  String toString() {
    return 'MessageModel{ id: $id, role: $role, content: $content,}';
  }

  MessageModel copyWith({
    String? id,
    Role? role,
    String? content,
  }) {
    return MessageModel(
      id: id ?? this.id,
      role: role ?? this.role,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'role': role.name,
      'content': content,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] as String? ?? '',
      role: Role.fromName(map['role'] as String? ?? ''),
      content: map['content'] as String? ?? '',
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
