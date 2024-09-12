import 'package:equatable/equatable.dart';

import 'grid_model.dart';
import 'position_model.dart';

class PathFindingRequest extends Equatable {
  final String id;
  final Grid grid;
  final Position start;
  final Position end;

  const PathFindingRequest({
    required this.id,
    required this.grid,
    required this.start,
    required this.end,
  });

  factory PathFindingRequest.fromJson(Map<String, dynamic> json) {
    return PathFindingRequest(
      id: json['id'],
      grid: Grid.fromJson(json),
      start: Position.fromJson(json['start']),
      end: Position.fromJson(json['end']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'grid': grid.toJson(),
      'start': start.toJson(),
      'end': end.toJson(),
    };
  }

  @override
  List<Object?> get props => [id, grid, start, end];
}
