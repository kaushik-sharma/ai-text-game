import 'package:ai_text_game/core/helpers/ui_helpers.dart';
import 'package:ai_text_game/core/widgets/custom_text_field.dart';
import 'package:ai_text_game/features/game/presentation/blocs/game_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/message_entity.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final GameBloc _bloc = sl<GameBloc>();
  final List<MessageEntity> _messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    _bloc.add(SendMessageEvent(_messages, _controller.text));
  }

  void _blocListener(context, state) {
    if (state is InputValidState) {
      _controller.clear();
      _messages.add(state.message);
      // TODO: SHOW LOADING
    }
    if (state is InputInvalidState) {}
    if (state is ChatCompletionSuccessState) {
      // TODO: HIDE LOADING
      _messages.add(state.message);
    }
    if (state is ChatCompletionFailureState) {
      // TODO: HIDE LOADING
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.error)),
      );
    }
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
              padding: EdgeInsets.all(20),
              child: BlocConsumer<GameBloc, GameState>(
                listener: _blocListener,
                builder: (context, state) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemCount: _messages.length,
                          itemBuilder: (context, index) => Text(
                            _messages[index].content,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10),
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        controller: _controller,
                        onSuffixPress: _sendMessage,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
