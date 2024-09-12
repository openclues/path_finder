import 'package:get_it/get_it.dart';
import 'package:path_finder/core/services/local_storage.dart';

import 'core/services/http_service.dart';
import 'core/services/http_service_impl.dart';
import 'features/home_screen/data/repositories/home_screen_repository_impl.dart';
import 'features/home_screen/domain/repositories/home_screen_repository.dart';
import 'features/home_screen/domain/use_cases/get_data_use_case.dart';

final sl = GetIt.instance;
Future init() async {
  // Services registration

  // Http Service
  sl.registerLazySingleton<HttpService>(() => HttpServiceImpl());
  sl.registerLazySingleton(() => SharedPreferencesService.fromLocator());

  // Repositories registration
  sl.registerLazySingleton<HomeScreenRepository>(() => HomeScreenRepositoryImpl(
      httpService: sl(), sharedPreferencesService: sl()));

  // Use cases registration
  sl.registerLazySingleton<GetDataUseCase>(() => GetDataUseCase(sl()));
}


//  create: (context) => ObtainPointsDataCubit(GetDataUseCase(
//                     HomeScreenRepositoryImpl(httpService: sl()))),