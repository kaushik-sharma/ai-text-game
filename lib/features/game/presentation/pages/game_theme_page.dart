import 'package:flutter/material.dart';

import '../../../../core/constants/app_data.dart';
import '../../../../core/constants/app_values.dart';
import '../../../../core/widgets/custom_button.dart';

class GameThemePage extends StatefulWidget {
  const GameThemePage({Key? key}) : super(key: key);

  @override
  State<GameThemePage> createState() => _GameThemePageState();
}

class _GameThemePageState extends State<GameThemePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kScaffoldPadding,
          ),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                  child: SizedBox(height: kScaffoldPadding)),
              SliverToBoxAdapter(
                child: Text(
                  'Select a story theme to start the game:',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
              SliverList.separated(
                itemCount: kStoryThemes.length,
                itemBuilder: (context, index) => Align(
                  alignment: Alignment.centerLeft,
                  child: CustomButton.secondary(
                    title: kStoryThemes[index],
                    onTap: () => _startGame(kStoryThemes[index]),
                    isCompact: true,
                    fontSize: 13,
                  ),
                ),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
              ),
              const SliverToBoxAdapter(
                  child: SizedBox(height: kScaffoldPadding)),
            ],
          ),
        ),
      ),
    );
  }

  void _startGame(String theme) {
    Navigator.pop<String>(context, theme);
  }
}
