import 'package:path_finder/features/processing/data/models/grid_model.dart';
import 'package:path_finder/features/processing/data/models/position_model.dart';
import 'package:path_finder/features/processing/data/models/shortest_path_result.dart';

import '../../data/models/step_model.dart';

class PathResultMapper {
  ShortestPathResult mapToShortestPathResult(
    String id,
    List<Position> path,
    Grid grid,
  ) {
    final steps = path
        .map((position) => StepModel(x: position.x, y: position.y))
        .toList();

    final pathString = path.map((e) => '(${e.x}, ${e.y})').join('->');

    return ShortestPathResult(
      id: id,
      grid: grid,
      steps: steps,
      path: pathString,
    );
  }
}
