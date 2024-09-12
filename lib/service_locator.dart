import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/services/dio_service_impl.dart';
import 'core/services/http_service.dart';
import 'core/services/local_storage.dart';
import 'core/services/path_finder_service.dart';
import 'features/processing/data/repositories/obtain_data_repository_impl.dart';
import 'features/processing/domain/mappers/path_result_mapper.dart';
import 'features/processing/domain/repositories/obtain_data_repository.dart';
import 'features/processing/domain/use_cases/get_data_use_case.dart';

final sl = GetIt.instance;
Future init() async {
  // Services registration
//register dio
  sl.registerLazySingleton<Dio>(() => Dio());
  // Http Service
  sl.registerLazySingleton<HttpService>(() => DioServiceImpl(dio: sl()));
  sl.registerLazySingleton(() => SharedPreferencesService.fromLocator());

  // Repositories registration
  sl.registerLazySingleton<ObtainDataRepository>(() => ObtainDataRepositoryImpl(
      httpService: sl(), sharedPreferencesService: sl()));

  // Use cases registration
  sl.registerLazySingleton<GetDataUseCase>(() => GetDataUseCase(sl()));

  sl.registerLazySingleton(() => PathFindingService());
  sl.registerLazySingleton(() => PathResultMapper());
}
