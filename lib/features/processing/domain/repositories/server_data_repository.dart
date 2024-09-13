import 'package:dartz/dartz.dart';
import 'package:path_finder/features/processing/data/models/results_response_model.dart';

import '../../../../core/common/models/base_responst_model.dart';
import '../../../../core/error/http_failure.dart';
import '../../data/models/path_finding_request.dart';
import '../../data/models/shortest_path_result.dart';

abstract class ServerDataRepository {
  Future<Either<HttpFailure, BaseResponseModel<List<PathFindingRequest>>?>>
      obtainData();

  Future<Either<HttpFailure, BaseResponseModel<List<ResultsResponseModel>>?>>
      sendResults(List<ShortestPathResult> shortestPathResults);
}
