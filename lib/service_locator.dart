import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:path_finder/features/processing/data/repositories/calculate_shortest_path_repository_impl.dart';
import 'package:path_finder/features/processing/data/repositories/server_data_repository_impl.dart';

import 'core/services/dio_service_impl.dart';
import 'core/services/http_service.dart';
import 'core/services/local_storage.dart';
import 'core/services/path_finder_service.dart';
import 'features/processing/domain/mappers/path_result_mapper.dart';
import 'features/processing/domain/repositories/calculate_shortest_path_repository.dart';
import 'features/processing/domain/repositories/server_data_repository.dart';
import 'features/processing/domain/use_cases/calculate_the_shortest_path_use_case.dart';
import 'features/processing/domain/use_cases/get_data_use_case.dart';
import 'features/processing/domain/use_cases/send_data_use_case.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Services registration
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<HttpService>(() => DioServiceImpl(dio: sl()));
  sl.registerLazySingleton<SharedPreferencesService>(
      () => SharedPreferencesService.fromLocator());
  sl.registerLazySingleton<PathFindingService>(() => PathFindingService());
  sl.registerLazySingleton<PathResultMapper>(() => PathResultMapper());

  // Repositories registration
  sl.registerLazySingleton<ServerDataRepository>(() => ServerDataRepositoryImpl(
        httpService: sl(),
        sharedPreferencesService: sl(),
      ));

  sl.registerLazySingleton<CalculateShortestPathRepository>(
      () => CalculateShortestPathRepositoryImpl(
            findingService: sl(),
            pathResultMapper: sl(),
          ));

  // Use cases registration
  sl.registerLazySingleton<GetDataUseCase>(() => GetDataUseCase(sl()));
  sl.registerLazySingleton<CalculateTheShortestPathUseCase>(
      () => CalculateTheShortestPathUseCase(sl()));
  // SendDataUseCase
  sl.registerLazySingleton<SendDataUseCase>(() => SendDataUseCase(sl()));
}
