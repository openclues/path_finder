import 'package:bloc/bloc.dart';
import 'package:path_finder/core/constants/strings/config_strings.dart';
import 'package:path_finder/core/services/local_storage.dart';

part 'home_scree_state.dart';

class HomeScreeCubit extends Cubit<HomeScreeState> {
  final SharedPreferencesService _sharedPreferencesService;

  HomeScreeCubit(this._sharedPreferencesService) : super(HomeScreeInitial());

  void saveUrlForProcessing(String url) {
    _sharedPreferencesService.setData(ConfigStrings.baseUrl, url);
    emit(HomeScreenProcessDone());
  }
}
