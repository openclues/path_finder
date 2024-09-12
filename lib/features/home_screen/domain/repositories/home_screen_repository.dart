import 'package:dartz/dartz.dart';

import '../../../../core/common/models/base_responst_model.dart';
import '../../../../core/error/http_failure.dart';
import '../../data/models/grid_point_model.dart';

abstract class HomeScreenRepository {
  Future<Either<HttpFailure, BaseResponseModel<List<GridPointModel>>?>>
      getHomeScreenData(String? url);
}
