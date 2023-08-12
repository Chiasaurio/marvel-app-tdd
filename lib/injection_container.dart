import 'package:bia_flutter_test/core/network/network_info.dart';
import 'package:bia_flutter_test/features/characters/data/datasources/characters_remote_data_source.dart';
import 'package:bia_flutter_test/features/characters/data/repositories/characters_repository_impl.dart';
import 'package:bia_flutter_test/features/characters/domain/repositories/characters_repository.dart';
import 'package:bia_flutter_test/features/characters/domain/usecases/get_concrete_character.dart';
import 'package:bia_flutter_test/features/characters/domain/usecases/get_list_of_characters.dart';
import 'package:bia_flutter_test/features/characters/presentation/cubit/characters_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'package:http/http.dart' as http;

// import 'package:internet_connection_checker/internet_connection_checker.dart';
final sl = GetIt.instance;

void init() {
  //! Features - Characters
  //Bloc
  sl.registerFactory(
    () => CharactersCubit(
      concrete: sl(),
      list: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetConcreteCharacter(sl()));
  sl.registerLazySingleton(() => GetListOfCharacters(sl()));

  // Repository
  sl.registerLazySingleton<CharactersRepository>(
    () => CharactersRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<CharactersRemoteDataSource>(
    () => CharactersRemoteDataSourceImpl(client: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionCheckerPlus());
}
