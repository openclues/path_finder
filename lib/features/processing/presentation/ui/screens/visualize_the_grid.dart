import 'package:flutter/material.dart';
import 'package:path_finder/features/home_screen/data/models/cell_model.dart';
import 'package:path_finder/features/home_screen/data/models/path_finding_request.dart';

class VisualizeTheGrid extends StatefulWidget {
  static const String routeName = '/visualize_the_grid';
  final PathFindingRequest pathFindingRequest; // Make this non-nullable

  const VisualizeTheGrid({super.key, required this.pathFindingRequest});

  @override
  State<VisualizeTheGrid> createState() => _VisualizeTheGridState();
}

class _VisualizeTheGridState extends State<VisualizeTheGrid> {
  Color startColor = const Color(0xff64FFDA);
  Color endColor = const Color(0xff009688);
  Color obstacleColor = const Color(0xff000000);
  Color emptyColor = const Color(0xffffffff);

  cellColor(int row, int col) {
    int startCol = widget.pathFindingRequest.start.x;
    int startRow = widget.pathFindingRequest.start.y;

    int endCol = widget.pathFindingRequest.end.x;
    int endRow = widget.pathFindingRequest.end.y;

    // Get the cell value
    Cell cellValue = widget.pathFindingRequest.grid.cells[row][col];

    if (row == startRow && col == startCol) {
      return startColor;
    } else if (row == endRow && col == endCol) {
      return endColor;
    } else if (cellValue.type == CellType.obstacle) {
      return obstacleColor;
    } else {
      return emptyColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Extract the grid from the request
    final grid = widget.pathFindingRequest.grid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualize the Grid'),
      ),
      body: Center(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: grid.cells[0].length, // Number of columns
          ),
          itemBuilder: (context, index) {
            // Calculate the row and column from the index
            int row = index ~/ grid.cells[0].length;
            int col = index % grid.cells[0].length;

            // Return a container for each cell
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: cellColor(row, col),
              ),
              child: Center(
                child: Text(
                  '($col, $row)', // Display the position of the cell
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            );
          },
          itemCount: grid.cells.length * grid.cells[0].length,
        ),
      ),
    );
  }
}
