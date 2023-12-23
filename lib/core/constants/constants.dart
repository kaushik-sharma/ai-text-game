import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Metadata
late final String kAppVersion;
const String kAppName = 'QuestVerse';

/// Spacing
final double kScaffoldPadding = 20.r;

/// Urls
const String kBaseUrl =
    'https://us-west-2.aws.data.mongodb-api.com/app/ai-text-game-qlqia/endpoint';
const String kChatCompletionUrl = '$kBaseUrl/chatCompletion';

/// Local storage keys
const String kStorageKeyTheme = 'theme';
const String kStorageKeyMessages = 'messages';

const List<String> kStoryThemes = [
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
];
