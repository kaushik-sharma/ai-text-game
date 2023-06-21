import 'package:ai_text_game/features/game/domain/repositories/game_repository.dart';
import 'package:ai_text_game/features/game/domain/usecases/send_message_usecase.dart';
import 'package:ai_text_game/features/game/presentation/blocs/game_bloc.dart';
import 'package:ai_text_game/features/splash/data/datasources/user_datasource.dart';
import 'package:ai_text_game/features/splash/data/repositories/user_repository_impl.dart';
import 'package:ai_text_game/features/splash/domain/repositories/user_repository.dart';
import 'package:ai_text_game/features/splash/domain/usecases/create_user_usecase.dart';
import 'package:ai_text_game/features/splash/presentation/blocs/user_bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'core/device/device_info.dart';
import 'core/network/network_info.dart';
import 'features/game/data/datasources/game_datasource.dart';
import 'features/game/data/repositories/game_repository_impl.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  await _injectExternal();
  _injectCore();
  _injectGame();
  _injectUser();
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
      networkInfo: sl(),
      deviceInfo: sl(),
    ),
  );

  /// Data sources
  sl.registerLazySingleton<GameDataSource>(
    () => GameDataSourceImpl(),
  );
}

void _injectUser() {
  /// Blocs
  sl.registerFactory(
    () => UserBloc(sl()),
  );

  /// Use cases
  sl.registerLazySingleton(() => CreateUserUseCase(sl()));

  /// Repositories
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      dataSource: sl(),
      networkInfo: sl(),
      deviceInfo: sl(),
    ),
  );

  /// Data sources
  sl.registerLazySingleton<UserDataSource>(
    () => UserDataSourceImpl(),
  );
}

void _injectCore() {
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton<DeviceInfo>(
      () => DeviceInfoImpl(deviceInfoPlugin: sl()));
}

Future<void> _injectExternal() async {
  sl.registerLazySingleton(() => InternetConnectionCheckerPlus());
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => DeviceInfoPlugin());
  // TODO: HIVE
}
