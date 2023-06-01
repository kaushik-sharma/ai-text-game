import 'package:ai_text_game/core/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../../../game/presentation/pages/theme_page.dart';
import '../blocs/user_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final UserBloc _bloc = sl<UserBloc>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _bloc.add(const CreateUserEvent());
    });
  }

  void _blocListener(BuildContext context, UserState state) {
    if (state is UserCreatedFailureState) {
      UiHelpers.showSnackBar(context, state.message);
    }
    if (state is UserCreatedSuccessState) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ThemePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (context) => _bloc,
      child: BlocConsumer<UserBloc, UserState>(
        listener: _blocListener,
        builder: (context, state) => Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                'AI Adventure'.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
