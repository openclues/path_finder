import 'package:path_finder/features/processing/data/models/shortest_path_result.dart';
import 'package:path_finder/features/processing/domain/repositories/calculate_shortest_path_repository.dart';

import '../../data/models/path_finding_request.dart';

class CalculateTheShortestPathUseCase {
  final CalculateShortestPathRepository _calculateShortestPathRepository;

  CalculateTheShortestPathUseCase(this._calculateShortestPathRepository);

  Future<List<ShortestPathResult>> call(
      {required List<PathFindingRequest> pathFindingRequests,
      required void Function(int completed, int total) onProgress,
      required void Function(String error) onError}) {
    return _calculateShortestPathRepository.processPaths(
      onProgress: onProgress,
      pathFindingRequests: pathFindingRequests,
      onError: onError,
    );
  }
}
