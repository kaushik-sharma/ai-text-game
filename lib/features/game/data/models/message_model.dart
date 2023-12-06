import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/message_entity.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
class MessageModel extends MessageEntity with _$MessageModel {
  const factory MessageModel({
    required Role role,
    required String content,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}

enum Role {
  @JsonValue('user')
  user(name: 'user'),
  @JsonValue('assistant')
  assistant(name: 'assistant');

  final String name;

  const Role({
    required this.name,
  });

  static Role fromName(String name) => Role.values.byName(name);
}
