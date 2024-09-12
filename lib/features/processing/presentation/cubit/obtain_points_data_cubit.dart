import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path_finder/features/processing/domain/use_cases/get_data_use_case.dart';

import '../../../../core/error/http_failure.dart';
import '../../../home_screen/data/models/path_finding_request.dart';

part 'obtain_points_data_state.dart';

class ObtainPointsDataCubit extends Cubit<ObtainPointsDataState> {
  final GetDataUseCase getDataUseCase;
  ObtainPointsDataCubit(this.getDataUseCase) : super(ObtainPointsDataInitial());

  getData() async {
    emit(ObtainPointsDataLoading());
    final result = await getDataUseCase();
    result.fold(
      (failure) => emit(ObtainPointsDataError(failure)),
      (data) => emit(ObtainPointsDataLoaded(data!.data)),
    );
  }
}
