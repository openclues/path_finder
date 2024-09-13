import 'package:dartz/dartz.dart';
import 'package:path_finder/features/processing/domain/repositories/server_data_repository.dart';

import '../../../../core/common/models/base_responst_model.dart';
import '../../../../core/error/http_failure.dart';
import '../../data/models/path_finding_request.dart';

class GetDataUseCase {
  final ServerDataRepository _serverDataRepository;

  GetDataUseCase(this._serverDataRepository);

  Future<Either<HttpFailure, BaseResponseModel<List<PathFindingRequest>>?>>
      call() async {
    return await _serverDataRepository.obtainData();
  }
}
