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
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage() {
    _bloc.add(SendMessageEvent(_messages, _controller.text));
  }

  void _blocListener(BuildContext context, GameState state) {
    if (state is InputValidState) {
      _controller.clear();
      _messages.add(state.message);
      _isLoading = true;
    }
    if (state is InputInvalidState) {}
    if (state is ChatCompletionSuccessState) {
      _isLoading = false;
      _messages.add(state.message);
      _scrollController.jumpTo(
        _scrollController.position.maxScrollExtent,
      );
    }
    if (state is ChatCompletionFailureState) {
      _isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.error)),
      );
    }
  }

  Widget _blocBuilder(BuildContext context, GameState state) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            controller: _scrollController,
            itemCount: _messages.length,
            itemBuilder: (context, index) => TextCard(
              message: _messages[index],
              isLast: index == _messages.length - 1,
            ),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Divider(
                color: Colors.grey.withOpacity(0.25),
                thickness: 0.5,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        if (_isLoading)
          const Align(
            alignment: Alignment.centerLeft,
            child: CustomLoadingIndicator(),
          ),
        const SizedBox(height: 10),
        CustomTextField(
          controller: _controller,
          onSuffixPress: _sendMessage,
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
