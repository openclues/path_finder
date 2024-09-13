// cell_helper.dart
import 'package:flutter/material.dart';
import 'package:path_finder/features/processing/data/models/cell_model.dart';
import 'package:path_finder/features/processing/data/models/position_model.dart';
import 'package:path_finder/features/processing/data/models/shortest_path_result.dart';

class CellHelper {
  static Color getCellColor({
    required int row,
    required int col,
    required List<Position> shortestPath,
    required ShortestPathResult shortestPathResult,
  }) {
    const Color startColor = Color(0xff64FFDA);
    const Color endColor = Color(0xff009688);
    const Color obstacleColor = Color(0xff000000);
    const Color emptyColor = Color(0xffffffff);
    const Color shortestPathColor = Color(0xff4CAF50);

    int startCol = shortestPathResult.steps.first.x;
    int startRow = shortestPathResult.steps.first.y;

    int endCol = shortestPathResult.steps.last.x;
    int endRow = shortestPathResult.steps.last.y;

    Cell cellValue = shortestPathResult.grid.cells[row][col];

    if (row == startRow && col == startCol) {
      return startColor;
    } else if (row == endRow && col == endCol) {
      return endColor;
    } else if (cellValue.type == CellType.obstacle) {
      return obstacleColor;
    } else if (shortestPath.contains(Position(x: col, y: row))) {
      return shortestPathColor;
    } else {
      return emptyColor;
    }
  }
}
