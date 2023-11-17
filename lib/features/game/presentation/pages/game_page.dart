import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_values.dart';
import '../../../../core/helpers/ui_helpers.dart';
import '../../../../core/widgets/custom_loading_indicator.dart';
import '../../../../core/widgets/custom_text_field.dart';
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
  final List<MessageEntity> _displayMessages = [];

  final TextEditingController _textController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    if (widget.messages == null) {
      _bloc.add(InitializeGameEvent(widget.theme));
      return;
    }
    _messages.addAll([...widget.messages!]);
    _displayMessages.addAll([...widget.messages!]);
    _displayMessages.removeLast();
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
              padding: const EdgeInsets.only(
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
    _bloc.add(SendMessageEvent(widget.theme, _messages, _textController.text));
  }

  void _blocListener(BuildContext context, GameState state) {
    if (state is InputValidState) {
      _textController.clear();
      _messages.insert(0, state.message);
      if (_messages.length > 1) {
        _displayMessages.insert(0, state.message);
      }
      _isLoading = true;
    }
    if (state is InputInvalidState) {}
    if (state is ChatCompletionSuccessState) {
      _messages.insert(0, state.message);
      _displayMessages.insert(0, state.message);
      _isLoading = false;
    }
    if (state is ChatCompletionFailureState) {
      UiHelpers.showSnackBar(context, state.error);
      _isLoading = false;
    }
  }

  Widget _blocBuilder(BuildContext context, GameState state) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            reverse: true,
            padding: const EdgeInsets.only(top: kScaffoldPadding),
            itemCount: _displayMessages.length,
            itemBuilder: (context, index) => TextCard(
              key: UniqueKey(),
              message: _displayMessages[index],
              shouldAnimate: index == 0 && shouldAnimate,
              onAnimComplete: () => _bloc.add(const AnimationCompleteEvent()),
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 20),
          ),
        ),
        const SizedBox(height: kScaffoldPadding),
        CustomTextField(
          controller: _textController,
          onFieldSubmitted:
              _isLoading || shouldAnimate ? null : (_) => _sendMessage(),
          suffix: _isLoading || shouldAnimate
              ? const CustomLoadingIndicator()
              : IconButton(
                  onPressed: _sendMessage,
                  iconSize: 34,
                  icon: const Icon(Icons.chevron_right_rounded),
                ),
        ),
      ],
    );
  }
}
