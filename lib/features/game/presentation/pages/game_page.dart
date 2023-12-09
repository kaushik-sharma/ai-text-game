import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/core.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/message_entity.dart';
import '../blocs/game_bloc.dart';
import '../widgets/text_card.dart';

class GamePage extends StatefulWidget {
  final String theme;
  final List<MessageEntity>? messages;

  const GamePage({
    super.key,
    required this.theme,
    this.messages,
  });

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final GameBloc _bloc = sl<GameBloc>();

  final List<MessageEntity> _messages = [];

  final TextEditingController _textController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    if (widget.messages == null) {
      _bloc.add(GameEvent.initializeGame(widget.theme));
      return;
    }
    _messages.addAll([...widget.messages!]);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GameBloc>(
      create: (context) => _bloc,
      child: GestureDetector(
        onTap: () => UiHelpers.hideKeyboard(),
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: kScaffoldPadding,
                right: kScaffoldPadding,
                bottom: kScaffoldPadding,
              ),
              child: BlocConsumer<GameBloc, GameState>(
                listener: _blocListener,
                builder: _blocBuilder,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _sendMessage() {
    _bloc.add(
        GameEvent.sendMessage(widget.theme, _messages, _textController.text));
  }

  void _blocListener(BuildContext context, GameState state) {
    state.when(
      initial: () {},
      inputValid: (message) {
        _textController.clear();
        _messages.insert(0, message);
        _isLoading = true;
      },
      inputInvalid: () {},
      chatCompletionSuccess: (message) {
        _messages.insert(0, message);
        _isLoading = false;
      },
      chatCompletionFailure: (error) async {
        UiHelpers.showSnackBar(error);

        /// End current game on initialization failure
        if (_messages.length == 1) {
          await StorageHelpers.resetGame(sl());
          kSavedGame = null;
          if (!mounted) return;
          Navigator.pop(context);
          return;
        }

        /// Clear prev user response
        _messages.removeAt(0);
        await StorageHelpers.saveGame(sl(), GameData(widget.theme, _messages));

        _isLoading = false;
      },
      animationCompleteSuccess: () {},
    );
  }

  Widget _blocBuilder(BuildContext context, GameState state) {
    final List<MessageEntity> messages =
        _messages.isNotEmpty ? _messages.sublist(0, _messages.length - 1) : [];

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            reverse: true,
            padding: EdgeInsets.only(top: kScaffoldPadding),
            itemCount: messages.length,
            itemBuilder: (context, index) => TextCard(
              key: UniqueKey(),
              message: messages[index],
              shouldAnimate: index == 0 && shouldAnimate,
              onAnimComplete: () =>
                  _bloc.add(const GameEvent.animationComplete()),
            ),
            separatorBuilder: (context, index) => SizedBox(height: 20.h),
          ),
        ),
        SizedBox(height: kScaffoldPadding),
        CustomTextField(
          controller: _textController,
          onFieldSubmitted:
              _isLoading || shouldAnimate ? null : (_) => _sendMessage(),
          suffix: _isLoading || shouldAnimate
              ? const CustomLoadingIndicator()
              : IconButton(
                  onPressed: _sendMessage,
                  iconSize: 34.r,
                  icon: const Icon(Icons.chevron_right_rounded),
                ),
        ),
      ],
    );
  }
}
