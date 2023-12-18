import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/core.dart';
import '../../../../injection_container.dart';
import '../../../../routes/custom_navigator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final items = [
      CustomButton.primary(
        title: 'New game',
        onTap: _startNewGame,
      ),
      if (kSavedGame != null)
        CustomButton.secondary(
          title: 'Continue',
          onTap: _continueGame,
        ),
    ];

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(kScaffoldPadding),
            child: Stack(
              children: [
                Positioned(
                  top: 80.h,
                  left: 0,
                  right: 0,
                  child: Text(
                    kAppName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 35.sp,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 250.w,
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: items.length,
                      itemBuilder: (context, index) => items[index],
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 20.h),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Text(
                    'v$kAppVersion',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 8.sp,
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.5),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _startNewGame() async {
    if (kSavedGame != null) {
      final bool? isConfirmed = await UiHelpers.showConfirmDialog(
        title: 'Are you sure?',
        content: 'All your saved progress will be lost.',
      );
      if (isConfirmed == null || !isConfirmed) {
        return;
      }
    }

    await StorageHelpers.resetGame(sl());
    kSavedGame = null;
    setState(() {});

    if (!mounted) return;
    final String? theme =
        await Navigator.pushNamed(context, AppRoute.gameTheme.name) as String?;
    if (theme == null) return;
    if (!mounted) return;
    await Navigator.pushNamed(context, AppRoute.game.name,
        arguments: {'theme': theme});

    kSavedGame = await StorageHelpers.getSavedGame(sl());
    setState(() {});
  }

  Future<void> _continueGame() async {
    await Navigator.pushNamed(
      context,
      AppRoute.game.name,
      arguments: {
        'theme': kSavedGame!.theme,
        'messages': kSavedGame!.messages,
      },
    );

    kSavedGame = await StorageHelpers.getSavedGame(sl());
    setState(() {});
  }
}
