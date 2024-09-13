import 'package:equatable/equatable.dart';

class Position extends Equatable {
  final int x;
  final int y;

  const Position({
    required this.x,
    required this.y,
  });

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      x: json['x'],
      y: json['y'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
    };
  }

  @override
  List<Object?> get props => [x, y];
}
