import 'package:ai_text_game/features/game/domain/repositories/game_repository.dart';
import 'package:ai_text_game/features/game/domain/usecases/send_message_usecase.dart';
import 'package:ai_text_game/features/game/presentation/blocs/game_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'core/network/network_info.dart';
import 'features/game/data/datasources/game_datasource.dart';
import 'features/game/data/repositories/game_repository_impl.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  _injectCore();
  await _injectExternal();
  _injectGame();
}

void _injectGame() {
  /// Blocs
  sl.registerFactory(
    () => GameBloc(
      sendMessageUseCase: sl(),
    ),
  );

  /// Use cases
  sl.registerLazySingleton(() => SendMessageUseCase(sl()));

  /// Repositories
  sl.registerLazySingleton<GameRepository>(
    () => GameRepositoryImpl(
      dataSource: sl(),
    ),
  );

  /// Data sources
  sl.registerLazySingleton<GameDataSource>(
    () => GameDataSourceImpl(),
  );
}

void _injectCore() {
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
}

Future<void> _injectExternal() async {
  sl.registerLazySingleton(() => InternetConnectionCheckerPlus());
  sl.registerLazySingleton(() => Dio());
}
