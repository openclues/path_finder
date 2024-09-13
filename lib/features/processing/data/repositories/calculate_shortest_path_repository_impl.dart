import 'package:path_finder/features/processing/data/models/path_finding_request.dart';

import 'package:path_finder/features/processing/data/models/shortest_path_result.dart';

import '../../../../core/services/path_finder_service.dart';
import '../../domain/mappers/path_result_mapper.dart';
import '../../domain/repositories/calculate_shortest_path_repository.dart';

class CalculateShortestPathRepositoryImpl
    implements CalculateShortestPathRepository {
  final PathFindingService _findingService;
  final PathResultMapper _pathResultMapper;

  CalculateShortestPathRepositoryImpl(
      {required PathFindingService findingService,
      required PathResultMapper pathResultMapper})
      : _findingService = findingService,
        _pathResultMapper = pathResultMapper;

  @override
  Future<List<ShortestPathResult>> processPaths(
      {required void Function(int completed, int total) onProgress,
      required List<PathFindingRequest> pathFindingRequests,
      required void Function(String error) onError}) async {
    List<ShortestPathResult> paths = [];

    for (var request in pathFindingRequests) {
      final path = _findingService.findPath(request);

      onProgress(paths.length + 1, pathFindingRequests.length);

      await Future.delayed(const Duration(milliseconds: 500));
      final shortestPathResult = _pathResultMapper.mapToShortestPathResult(
          request.id, path, request.grid);

      paths.add(shortestPathResult);

      onProgress(paths.length, pathFindingRequests.length);
    }
    return paths;
  }
}
