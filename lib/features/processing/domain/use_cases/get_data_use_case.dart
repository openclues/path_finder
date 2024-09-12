import 'package:dartz/dartz.dart';
import 'package:path_finder/features/processing/domain/repositories/obtain_data_repository.dart';

import '../../../../core/common/models/base_responst_model.dart';
import '../../../../core/error/http_failure.dart';
import '../../../home_screen/data/models/path_finding_request.dart';

class GetDataUseCase {
  final ObtainDataRepository _obtainDataRepository;

  GetDataUseCase(this._obtainDataRepository);

  Future<Either<HttpFailure, BaseResponseModel<List<PathFindingRequest>>?>>
      call() async {
    return await _obtainDataRepository.obtainData();
  }
}
