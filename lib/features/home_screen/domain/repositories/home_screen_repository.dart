import 'package:dartz/dartz.dart';

import '../../../../core/common/models/base_responst_model.dart';
import '../../../../core/error/http_failure.dart';
import '../../data/models/path_finding_request.dart';

abstract class HomeScreenRepository {
  Future<Either<HttpFailure, BaseResponseModel<List<PathFindingRequest>>?>>
      getHomeScreenData(String? url);
}
