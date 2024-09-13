import 'package:dartz/dartz.dart';

import 'package:path_finder/core/common/models/base_responst_model.dart';
import 'package:path_finder/core/constants/strings/config_strings.dart';

import 'package:path_finder/core/error/http_failure.dart';
import 'package:path_finder/core/services/local_storage.dart';
import 'package:path_finder/features/processing/data/models/results_response_model.dart';

import '../../../../core/services/http_service.dart';
import '../models/path_finding_request.dart';
import '../../domain/repositories/server_data_repository.dart';
import '../models/shortest_path_result.dart';

class ServerDataRepositoryImpl implements ServerDataRepository {
  final HttpService _httpService;
  final SharedPreferencesService _sharedPreferencesService;

  ServerDataRepositoryImpl(
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

  @override
  Future<Either<HttpFailure, BaseResponseModel<List<ResultsResponseModel>>?>>
      sendResults(List<ShortestPathResult> shortestPathResults) async {
    //get url
    String? url = _sharedPreferencesService.getData(ConfigStrings.baseUrl);
    if (url == null) {
      return const Left(InternalAppHttpFailure('No url found'));
    }
    //make the request
    return _httpService.post<BaseResponseModel<List<ResultsResponseModel>>>(
      url: url,
      body: shortestPathResults.map((e) => e.toJson()).toList(),
      fromJson: (decodedJson) =>
          BaseResponseModel<List<ResultsResponseModel>>.fromJson(
        decodedJson,
        (json) => (json as List)
            .map((e) => ResultsResponseModel.fromJson(e))
            .toList(),
      ),
    );
  }
}
