import 'package:ai_text_game/core/widgets/custom_button.dart';
import 'package:ai_text_game/features/game/presentation/pages/game_page.dart';
import 'package:flutter/material.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({Key? key}) : super(key: key);

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  final _storyThemes = [
    'Fantasy',
    'Sci-Fi',
    'Post-Apocalyptic Survival',
    'Historical',
    'Pirate Adventure',
    'Mythological Quest',
    'Zombie Apocalypse',
    'Steampunk Adventure',
    'Superhero Journey',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select a story theme to start the game:',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: _storyThemes.length,
                  itemBuilder: (context, index) => UnconstrainedBox(
                    alignment: Alignment.centerLeft,
                    child: CustomButton(
                      text: _storyThemes[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GamePage(),
                            settings: RouteSettings(
                              arguments: {
                                'theme': _storyThemes[index],
                              },
                            ),
                          ),
                        );
                      },
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      textSize: 12,
                    ),
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
