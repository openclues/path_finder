import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path_finder/features/processing/data/models/shortest_path_result.dart';
import 'package:path_finder/features/home_screen/data/models/path_finding_request.dart';
import '../../../../core/services/path_finder_service.dart';
import '../../domain/mappers/path_result_mapper.dart';

part 'process_state.dart';

class ProcessCubit extends Cubit<ProcessProgress> {
  final PathFindingService pathFindingService;
  final PathResultMapper pathResultMapper;

  ProcessCubit(this.pathFindingService, this.pathResultMapper)
      : super(const ProcessProgress());

  Future<void> findShortestPath(
      List<PathFindingRequest> pathFindingRequests) async {
    emit(ProcessProgress(
      completed: 0,
      total: pathFindingRequests.length + 1,
      path: const [],
    ));

    List<ShortestPathResult> paths = [];

    for (var request in pathFindingRequests) {
      final path = pathFindingService.findPath(request);

      emit(ProcessProgress(
        completed: paths.length + 1,
        total: pathFindingRequests.length,
      ));

      final shortestPathResult = pathResultMapper.mapToShortestPathResult(
          request.id, path, request.grid);

      paths.add(shortestPathResult);

      emit(ProcessProgress(
        completed: paths.length,
        total: pathFindingRequests.length,
        path: paths,
      ));
    }
  }
}
