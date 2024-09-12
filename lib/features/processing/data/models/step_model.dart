import 'package:equatable/equatable.dart';

class StepModel extends Equatable {
  final int x;
  final int y;

  const StepModel({
    required this.x,
    required this.y,
  });

  Map<String, dynamic> toJson() {
    return {
      'x': x.toString(),
      'y': y.toString(),
    };
  }

  @override
  List<Object?> get props => [x, y];
}
