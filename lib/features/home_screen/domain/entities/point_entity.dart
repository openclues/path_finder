abstract class GridEntity {
  final String id;
  final List<String> field; // Flat list representation
  final Vector start;
  final Vector end;
  final int width;
  final int height;

  GridEntity({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
    required this.width,
    required this.height,
  });
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
