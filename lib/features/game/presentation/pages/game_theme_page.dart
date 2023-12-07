import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/core.dart';

class GameThemePage extends StatefulWidget {
  const GameThemePage({super.key});

  @override
  State<GameThemePage> createState() => _GameThemePageState();
}

class _GameThemePageState extends State<GameThemePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: kScaffoldPadding,
          ),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: kScaffoldPadding)),
              SliverToBoxAdapter(
                child: Text(
                  'Select a story theme to start the game:',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20.sp),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 20.h)),
              SliverList.separated(
                itemCount: kStoryThemes.length,
                itemBuilder: (context, index) => Align(
                  alignment: Alignment.centerLeft,
                  child: CustomButton.secondary(
                    title: kStoryThemes[index],
                    onTap: () => _startGame(kStoryThemes[index]),
                    isCompact: true,
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(height: 10.h),
              ),
              SliverToBoxAdapter(child: SizedBox(height: kScaffoldPadding)),
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
