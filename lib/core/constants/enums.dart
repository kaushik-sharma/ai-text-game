import 'package:freezed_annotation/freezed_annotation.dart';

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

enum ButtonMode {
  primary,
  secondary,
}
