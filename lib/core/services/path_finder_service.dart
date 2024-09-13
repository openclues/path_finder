import 'dart:collection';
import 'package:path_finder/features/processing/data/models/position_model.dart';

import '../../features/processing/data/models/path_finding_request.dart';

class PathFindingService {
  List<Position> findPath(PathFindingRequest request) {
    final start = request.start;
    final end = request.end;
    final grid = request.grid;

    final directions = [
      const Position(x: 0, y: -1), // Up
      const Position(x: 0, y: 1), // Down
      const Position(x: -1, y: 0), // Left
      const Position(x: 1, y: 0), // Right
      const Position(x: -1, y: -1), // Top-Left
      const Position(x: 1, y: -1), // Top-Right
      const Position(x: -1, y: 1), // Bottom-Left
      const Position(x: 1, y: 1), // Bottom-Right
    ];

    final queue = Queue<List<Position>>();
    final visited = <Position>{};
    final parent = <Position, Position?>{};

    queue.add([start]);
    visited.add(start);
    parent[start] = null;

    while (queue.isNotEmpty) {
      final path = queue.removeFirst();
      final current = path.last;

      if (current == end) {
        return _reconstructPath(end, parent);
      }

      for (var direction in directions) {
        final next = Position(
          x: current.x + direction.x,
          y: current.y + direction.y,
        );

        if (grid.isValidPosition(next) &&
            !grid.isObstacle(next) &&
            !visited.contains(next)) {
          visited.add(next);
          queue.add(List.from(path)..add(next));
          parent[next] = current;
        }
      }
    }

    return [];
  }

  List<Position> _reconstructPath(
      Position end, Map<Position, Position?> parent) {
    final reconstructedPath = <Position>[];
    Position? current = end;

    while (current != null) {
      reconstructedPath.add(current);
      current = parent[current];
    }

    return reconstructedPath.reversed.toList();
  }
}
