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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kScaffoldPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select a story theme to start the game:',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary, fontSize: 20),
              ),
              const SizedBox(height: 20),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
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
