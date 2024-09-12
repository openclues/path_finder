import 'package:dartz/dartz.dart';

import '../../../../core/common/models/base_responst_model.dart';
import '../../../../core/error/http_failure.dart';
import '../../../home_screen/data/models/path_finding_request.dart';

abstract class ObtainDataRepository {
  Future<Either<HttpFailure, BaseResponseModel<List<PathFindingRequest>>?>>
      obtainData();
}
