import '../../features/game/domain/entities/message_entity.dart';

class GameData {
  final String theme;
  final List<MessageEntity> messages;

  const GameData(this.theme, this.messages);
}

GameData? kSavedGame;

final List<String> kStoryThemes = List.unmodifiable(
  [
    'Medieval Fantasy',
    'Sci-Fi Space Exploration',
    'Post-Apocalyptic Survival',
    'Time Travel Adventure',
    'Mystery Detective',
    'Historical Adventure',
    'Supernatural Horror',
    'Pirate Adventure',
    'Wild West Frontier',
    'Fairy Tale Quest',
    'Steampunk Mystery',
    'Mythological Quest',
    'Cyberpunk Dystopia',
    'Lovecraftian Horror',
    'Superhero Origins',
    'Sports Adventure',
    'Parallel Universes',
    'Underwater Exploration',
    'Political Intrigue',
    'Futuristic Survival',
  ],
);
