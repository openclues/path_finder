import 'package:path_finder/features/processing/data/models/shortest_path_result.dart';
import 'package:path_finder/features/processing/data/models/path_finding_request.dart';

abstract class CalculateShortestPathRepository {
  Future<List<ShortestPathResult>> processPaths({
    required List<PathFindingRequest> pathFindingRequests,
    required void Function(int completed, int total) onProgress,
    required void Function(String error) onError,
  });
}
