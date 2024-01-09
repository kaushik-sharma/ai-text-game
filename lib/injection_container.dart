import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/core.dart';
import 'features/game/data/datasources/game_datasource.dart';
import 'features/game/data/repositories/game_repository_impl.dart';
import 'features/game/domain/repositories/game_repository.dart';
import 'features/game/domain/usecases/send_message_usecase.dart';
import 'features/game/presentation/blocs/game_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  await _injectExternal();
  _injectCore();
  _injectGame();
}

void _injectGame() {
  /// Data sources
  sl.registerLazySingleton<GameDataSource>(
    () => GameDataSourceImpl(
      dio: sl<Dio>(),
      sharedPreferences: sl<SharedPreferences>(),
    ),
  );

  /// Repositories
  sl.registerLazySingleton<GameRepository>(
    () => GameRepositoryImpl(
      dataSource: sl<GameDataSource>(),
      networkInfo: sl<NetworkInfo>(),
      storage: sl<Storage>(),
    ),
  );

  /// Use cases
  sl.registerLazySingleton<SendMessageUseCase>(
    () => SendMessageUseCase(sl<GameRepository>()),
  );

  /// Blocs
  sl.registerSingleton<GameBloc>(
    GameBloc(
      sendMessageUseCase: sl<SendMessageUseCase>(),
    ),
  );
}

void _injectCore() {
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnection: sl<InternetConnection>()));
  sl.registerLazySingleton<Storage>(() => const StorageImpl());
}

Future<void> _injectExternal() async {
  sl.registerLazySingleton<InternetConnection>(() => InternetConnection());
  sl.registerLazySingleton<Dio>(() => CustomDio.instance);
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}
