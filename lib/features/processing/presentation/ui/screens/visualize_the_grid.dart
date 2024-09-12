import 'package:flutter/material.dart';
import 'package:path_finder/features/processing/data/models/shortest_path_result.dart';
import 'package:path_finder/features/home_screen/data/models/position_model.dart';
import 'cell_helper.dart'; // Import the cell helper
import 'grid_helper.dart'; // Import the grid helper

class VisualizeTheGrid extends StatefulWidget {
  static const String routeName = '/visualize_the_grid';
  final ShortestPathResult shortestPathResult;

  const VisualizeTheGrid({super.key, required this.shortestPathResult});

  @override
  State<VisualizeTheGrid> createState() => _VisualizeTheGridState();
}

class _VisualizeTheGridState extends State<VisualizeTheGrid> {
  late final List<Position> shortestPath;

  // Define colors for various cell states

  @override
  void initState() {
    super.initState();
    shortestPath = widget.shortestPathResult.steps
        .map((e) => Position(x: e.x, y: e.y))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final grid = widget.shortestPathResult.grid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualize the Grid'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: grid.width,
              ),
              itemBuilder: (context, index) {
                int row = GridHelper.getRowIndex(index, grid);
                int col = GridHelper.getColIndex(index, grid);

                final Color containerColor = CellHelper.getCellColor(
                  row: row,
                  col: col,
                  shortestPath: shortestPath,
                  shortestPathResult: widget.shortestPathResult,
                );

                return _buildGridCell(row, col, containerColor);
              },
              itemCount: GridHelper.calculateItemCount(grid),
            ),
          ),
          Expanded(
              child: Text(widget.shortestPathResult.path,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center)),
        ],
      ),
    );
  }

  // Build the individual grid cell
  Widget _buildGridCell(int row, int col, Color containerColor) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: containerColor,
      ),
      child: Center(
        child: Text(
          '($col, $row)',
          style: TextStyle(
            fontSize: 14,
            color: containerColor == Colors.black ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  // Build the bottom bar with the shortest path and actions
}
