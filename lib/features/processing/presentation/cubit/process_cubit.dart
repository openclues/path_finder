import 'package:bloc/bloc.dart';
import 'package:path_finder/features/processing/data/models/shortest_path_result.dart';
import 'package:path_finder/features/processing/domain/use_cases/calculate_the_shortest_path_use_case.dart';
import 'package:path_finder/features/processing/domain/use_cases/get_data_use_case.dart';
import 'package:path_finder/features/processing/domain/use_cases/send_data_use_case.dart';

import 'process_state.dart';

class ProcessCubit extends Cubit<ProcessState> {
  final GetDataUseCase getDataUseCase;
  final SendDataUseCase sendDataUseCase;
  final CalculateTheShortestPathUseCase calculateTheShortestPathUseCase;

  ProcessCubit(
    this.getDataUseCase,
    this.calculateTheShortestPathUseCase,
    this.sendDataUseCase,
  ) : super(ProcessInitial());

  Future<void> executeProcess() async {
    emit(ObtainPointsDataLoading());

    final result = await getDataUseCase.call();
    result.fold(
      (failure) => emit(ObtainPointsDataError(failure.message)),
      (data) async {
        emit(ObtainPointsDataLoaded(data!.data));
        try {
          emit(ProcessProgress(
            completed: 0,
            total: data.data.length,
            path: const [],
          ));

          List<ShortestPathResult> shortestPathResult =
              await calculateTheShortestPathUseCase.call(
            pathFindingRequests: data.data,
            onProgress: (completed, total) {
              emit(ProcessProgress(
                completed: completed,
                total: total,
                path: (state as ProcessProgress).path,
              ));
            },
            onError: (error) {
              emit(ProcessProgress(
                completed: (state as ProcessProgress).completed,
                total: (state as ProcessProgress).total,
                path: (state as ProcessProgress).path,
                error: error,
              ));
            },
          );

          // Final state when the process is completed
          emit(ProcessProgress(
            completed: data.data.length,
            total: data.data.length,
            path: shortestPathResult,
          ));
        } catch (e) {
          emit(ProcessProgress(
            completed: 0,
            total: data.data.length,
            path: const [],
            error: e.toString(),
          ));
        }
      },
    );
  }

  Future<void> sendDataToServer() async {
    final currentState = state;
    List<ShortestPathResult>? path;
    if (currentState is SendDataError && currentState.path.isNotEmpty) {
      path = currentState.path; // Use the path from SendDataError
    } else if (currentState is ProcessProgress &&
        currentState.path.isNotEmpty) {
      path = currentState.path; // Use the path from ProcessProgress
    } else {
      emit(const SendDataError('No data to send.', []));
      return;
    }
    emit(SendDataLoading());
    final result = await sendDataUseCase.call(path);
    result.fold(
      (failure) => emit(SendDataError(failure.message, path!)),
      (data) => emit(SendDataSuccess(path!)),
    );
  }
}
