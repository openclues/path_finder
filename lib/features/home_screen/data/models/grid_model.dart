import 'package:equatable/equatable.dart';

import 'cell_model.dart';

class Grid extends Equatable {
  final List<List<Cell>> cells;

  const Grid({
    required this.cells,
  });

  factory Grid.fromJson(Map<String, dynamic> json) {
    final field = json['field'] as List<dynamic>;

    return Grid(
      cells: field
          .map((row) => (row as String)
              .split('')
              .map((char) => Cell.fromChar(char))
              .toList())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'field': cells,
    };
  }

  @override
  List<Object?> get props => [cells];
}
