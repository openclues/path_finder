import 'package:dartz/dartz.dart';

import '../../../../core/common/models/base_responst_model.dart';
import '../../../../core/error/http_failure.dart';
import '../../data/models/grid_point_model.dart';
import '../repositories/home_screen_repository.dart';

class GetDataUseCase {
  final HomeScreenRepository _homeScreenRepository;

  GetDataUseCase(this._homeScreenRepository);

  Future<Either<HttpFailure, BaseResponseModel<List<GridPointModel>>?>> call(
      String? url) async {
    return await _homeScreenRepository.getHomeScreenData(url);
  }
}
