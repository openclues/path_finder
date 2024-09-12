import 'package:dartz/dartz.dart';

import 'package:path_finder/core/common/models/base_responst_model.dart';
import 'package:path_finder/core/constants/strings/config_strings.dart';

import 'package:path_finder/core/error/http_failure.dart';
import 'package:path_finder/core/services/local_storage.dart';

import '../../../../core/services/http_service.dart';
import '../../../home_screen/data/models/path_finding_request.dart';
import '../../domain/repositories/obtain_data_repository.dart';

class ObtainDataRepositoryImpl implements ObtainDataRepository {
  final HttpService _httpService;
  final SharedPreferencesService _sharedPreferencesService;

  ObtainDataRepositoryImpl(
      {required HttpService httpService,
      required SharedPreferencesService sharedPreferencesService})
      : _httpService = httpService,
        _sharedPreferencesService = sharedPreferencesService;

  @override
  Future<Either<HttpFailure, BaseResponseModel<List<PathFindingRequest>>?>>
      obtainData() async {
    //get url
    String? url = _sharedPreferencesService.getData(ConfigStrings.baseUrl);
    if (url == null) {
      return const Left(InternalAppHttpFailure('No url found'));
    }

    //make the request
    return _httpService.get<BaseResponseModel<List<PathFindingRequest>>>(
      url: url,
      fromJson: (decodedJson) => BaseResponseModel.fromJson(
        decodedJson,
        (json) =>
            (json as List).map((e) => PathFindingRequest.fromJson(e)).toList(),
      ),
    );
  }
}
