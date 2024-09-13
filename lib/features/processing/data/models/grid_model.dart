import 'package:equatable/equatable.dart';

import 'cell_model.dart';
import 'position_model.dart';

class Grid extends Equatable {
  final List<List<Cell>> cells;
  final int height;
  final int width;

  const Grid({
    required this.cells,
    required this.height,
    required this.width,
  });

  factory Grid.fromJson(Map<String, dynamic> json) {
    final field = json['field'] as List<dynamic>;

    return Grid(
      height: field.length,
      width: (field.first as String).length,
      cells: field
          .map((row) => (row as String)
              .split('')
              .map((char) => Cell.fromChar(char))
              .toList())
          .toList(),
    );
  }
  bool isValidPosition(Position pos) {
    return pos.x >= 0 && pos.x < width && pos.y >= 0 && pos.y < height;
  }

  bool isObstacle(Position pos) {
    return cells[pos.y][pos.x].type == CellType.obstacle;
  }

  Map<String, dynamic> toJson() {
    return {
      'field': cells,
    };
  }

  @override
  List<Object?> get props => [cells, height, width];
}
