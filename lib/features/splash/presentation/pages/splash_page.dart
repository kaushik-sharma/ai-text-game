import 'package:ai_text_game/core/helpers/ui_helpers.dart';
import 'package:ai_text_game/features/game/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
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
          builder: (context) => const HomePage(),
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
        builder: (context, state) => const Scaffold(),
      ),
    );
  }
}
