import 'package:equatable/equatable.dart';

enum CellType { empty, obstacle }

class Cell extends Equatable {
  final CellType type;

  const Cell({
    required this.type,
  });

  factory Cell.fromChar(String char) {
    switch (char) {
      case 'X':
        return const Cell(type: CellType.obstacle);
      case '.':
        return const Cell(type: CellType.empty);
      default:
        throw ArgumentError('Invalid cell type');
    }
  }

  String toChar() {
    switch (type) {
      case CellType.obstacle:
        return 'X';
      case CellType.empty:
        return '.';
    }
  }

  @override
  List<Object?> get props => [type];
}
