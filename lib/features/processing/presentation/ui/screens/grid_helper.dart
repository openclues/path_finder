// grid_helper.dart
import 'package:path_finder/features/home_screen/data/models/grid_model.dart';

class GridHelper {
  static int calculateItemCount(Grid grid) {
    return grid.width * grid.height;
  }

  static int getRowIndex(int index, Grid grid) {
    return index ~/ grid.width;
  }

  static int getColIndex(int index, Grid grid) {
    return index % grid.width;
  }
}
