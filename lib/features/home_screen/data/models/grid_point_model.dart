class GridPointModel {
  final String id;
  final List<List<String>> field; // 2D representation of the grid
  final Vector start;
  final Vector end;

  GridPointModel({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  // Factory method to create a Grid instance from JSON
  factory GridPointModel.fromJson(Map<String, dynamic> json) {
    List<List<String>> field = (json['field'] as List<dynamic>)
        .map((row) => (row as String).split(''))
        .toList();

    return GridPointModel(
      id: json['id'],
      field: field,
      start: Vector.fromJson(json['start']),
      end: Vector.fromJson(json['end']),
    );
  }

  // Convert Grid instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'field': field.map((row) => row.join('')).toList(),
      'start': start.toJson(),
      'end': end.toJson(),
    };
  }
}

class Vector {
  final int x;
  final int y;

  Vector(this.x, this.y);

  factory Vector.fromJson(Map<String, dynamic> json) {
    return Vector(json['x'], json['y']);
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
    };
  }
}
