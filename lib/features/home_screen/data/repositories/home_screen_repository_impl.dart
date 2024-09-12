import 'package:dartz/dartz.dart';

import 'package:path_finder/core/common/models/base_responst_model.dart';
import 'package:path_finder/core/common/validators.dart';
import 'package:path_finder/core/constants/strings/config_strings.dart';

import 'package:path_finder/core/error/http_failure.dart';
import 'package:path_finder/core/services/local_storage.dart';

import '../../../../core/services/http_service.dart';
import '../../domain/repositories/home_screen_repository.dart';
import '../models/path_finding_request.dart';

class HomeScreenRepositoryImpl implements HomeScreenRepository {
  final HttpService _httpService;
  final SharedPreferencesService _sharedPreferencesService;

  HomeScreenRepositoryImpl(
      {required HttpService httpService,
      required SharedPreferencesService sharedPreferencesService})
      : _httpService = httpService,
        _sharedPreferencesService = sharedPreferencesService;

  @override
  Future<Either<HttpFailure, BaseResponseModel<List<PathFindingRequest>>?>>
      getHomeScreenData(String? url) async {
    //validation
    String? validateUrl = Validators.validateUrl(url);
    if (validateUrl != null) {
      //Invalid url
      return Left(InternalAppHttpFailure(validateUrl, code: 400));
    }

    //save url
    await _sharedPreferencesService.setData(ConfigStrings.baseUrl, url);

    //make the request
    return _httpService.get<BaseResponseModel<List<PathFindingRequest>>>(
      url: url!,
      fromJson: (decodedJson) => BaseResponseModel.fromJson(
        decodedJson,
        (json) =>
            (json as List).map((e) => PathFindingRequest.fromJson(e)).toList(),
      ),
    );
  }
}
