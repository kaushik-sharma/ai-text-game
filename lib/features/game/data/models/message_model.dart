import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constants/enums.dart';
import '../../domain/entities/message_entity.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
class MessageModel extends MessageEntity with _$MessageModel {
  const factory MessageModel({
    required String id,
    required Role role,
    required String content,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}
