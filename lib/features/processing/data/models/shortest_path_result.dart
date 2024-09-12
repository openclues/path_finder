import 'package:equatable/equatable.dart';
import 'package:path_finder/features/home_screen/data/models/grid_model.dart';

import 'step_model.dart';

class ShortestPathResult extends Equatable {
  final String id;
  final List<StepModel> steps;
  final String path;
  final Grid grid;

  const ShortestPathResult({
    required this.id,
    required this.steps,
    required this.path,
    required this.grid,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'result': {
        'steps': steps
            .map((e) => {
                  'x': e.x.toString(),
                  'y': e.y.toString(),
                })
            .toList(),
        'path': path,
      },
    };
  }

  @override
  List<Object?> get props => [id, steps, path, grid];
}
