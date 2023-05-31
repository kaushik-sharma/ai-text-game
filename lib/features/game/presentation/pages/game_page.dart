import 'package:ai_text_game/core/helpers/ui_helpers.dart';
import 'package:ai_text_game/core/widgets/custom_loading_indicator.dart';
import 'package:ai_text_game/core/widgets/custom_text_field.dart';
import 'package:ai_text_game/features/game/presentation/blocs/game_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/message_entity.dart';
import '../widgets/text_card.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      final theme = args['theme'] as String;
      _bloc.add(
        InitializeGameEvent(theme),
      );
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    _bloc.add(SendMessageEvent(_messages, _textController.text));
  }

  void _blocListener(BuildContext context, GameState state) {
    if (state is GameInitializingState) {
      _isLoading = true;
    }
    if (state is InputValidState) {
      _textController.clear();
      _messages.insert(0, state.message);
      _isLoading = true;
    }
    if (state is InputInvalidState) {}
    if (state is ChatCompletionSuccessState) {
      _messages.insert(0, state.message);
      _isLoading = false;
    }
    if (state is ChatCompletionFailureState) {
      _isLoading = false;
      UiHelpers.showSnackBar(context, state.error);
    }
  }

  Widget _blocBuilder(BuildContext context, GameState state) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            reverse: true,
            padding: EdgeInsets.zero,
            itemCount: _messages.length,
            itemBuilder: (context, index) => TextCard(
              key: UniqueKey(),
              message: _messages[index],
              isFirst: index == 0,
            ),
            separatorBuilder: (context, index) => SizedBox(
              key: UniqueKey(),
              height: 20,
            ),
          ),
        ),
        const SizedBox(height: 30),
        CustomTextField(
          controller: _textController,
          onFieldSubmitted: _isLoading ? (_) {} : (_) => _sendMessage(),
          suffix: _isLoading
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GameBloc>(
      create: (context) => _bloc,
      child: GestureDetector(
        onTap: () => UiHelpers.hideKeyboard(),
        child: Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
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
}
