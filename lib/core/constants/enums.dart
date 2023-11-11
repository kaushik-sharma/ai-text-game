enum Role {
  user(name: 'user'),
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
