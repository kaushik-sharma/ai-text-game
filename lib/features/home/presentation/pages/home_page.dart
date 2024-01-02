import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/core.dart';
import '../../../../injection_container.dart';
import '../../../../routes/router_config.dart';
import '../../../game/presentation/blocs/game_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GameBloc _bloc = sl<GameBloc>();

  @override
  Widget build(BuildContext context) {
    final items = [
      CustomButton.primary(
        title: 'New game',
        onTap: _startNewGame,
      ),
      if (_bloc.savedGame != null)
        CustomButton.secondary(
          title: 'Continue',
          onTap: _continueGame,
        ),
    ];

    return BlocProvider<GameBloc>(
      create: (context) => _bloc,
      child: BlocConsumer<GameBloc, GameState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            inputValid: (_) {},
            inputInvalid: () {},
            chatCompletionSuccess: (_) {},
            chatCompletionFailure: (_) {},
            gameSaveSuccess: () {
              setState(() {});
            },
          );
        },
        builder: (context, state) => Scaffold(
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
        ),
      ),
    );
  }

  Future<void> _startNewGame() async {
    if (_bloc.savedGame != null) {
      final bool? isConfirmed = await UiHelpers.showConfirmDialog(
        title: 'Are you sure?',
        content: 'All your saved progress will be lost.',
      );
      if (isConfirmed == null || !isConfirmed) {
        return;
      }
    }

    await StorageHelpers.resetGame(sl<SharedPreferences>());
    _bloc.add(const GameEvent.saveGame(null));

    if (!mounted) return;
    // Navigator.pushNamed(context, AppRoute.gameTheme.name);
    context.goNamed(Routes.gameTheme.name);
  }

  void _continueGame() {
    // Navigator.pushNamed(
    //   context,
    //   AppRoute.game.name,
    //   arguments: {
    //     'theme': _bloc.savedGame!.theme,
    //     'messages': _bloc.savedGame!.messages,
    //   },
    // );
    context.goNamed(
      Routes.game.name,
      pathParameters: {'theme': _bloc.savedGame!.theme},
      queryParameters: {'messages': jsonEncode(_bloc.savedGame!.messages)},
    );
  }
}
