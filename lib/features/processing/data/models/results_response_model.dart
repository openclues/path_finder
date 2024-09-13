import 'package:equatable/equatable.dart';

class ResultsResponseModel extends Equatable {
  final String id;
  final bool correct;

  const ResultsResponseModel({required this.id, required this.correct});

  //from json

  factory ResultsResponseModel.fromJson(Map<String, dynamic> json) {
    return ResultsResponseModel(
      id: json['id'],
      correct: json['correct'],
    );
  }

  @override
  List<Object> get props => [id, correct];
}
