import 'package:dartz/dartz.dart';
import 'package:path_finder/features/processing/domain/repositories/server_data_repository.dart';

import '../../../../core/common/models/base_responst_model.dart';
import '../../../../core/error/http_failure.dart';
import '../../data/models/results_response_model.dart';
import '../../data/models/shortest_path_result.dart';

class SendDataUseCase {
  final ServerDataRepository _serverDataRepository;

  SendDataUseCase(this._serverDataRepository);

  Future<Either<HttpFailure, BaseResponseModel<List<ResultsResponseModel>>?>>
      call(List<ShortestPathResult> shortestPathResults) async {
    return await _serverDataRepository.sendResults(shortestPathResults);
  }
}
