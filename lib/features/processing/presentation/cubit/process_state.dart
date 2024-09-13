import 'package:equatable/equatable.dart';
import 'package:path_finder/features/processing/data/models/shortest_path_result.dart';
import 'package:path_finder/features/processing/data/models/path_finding_request.dart';

abstract class ProcessState extends Equatable {
  const ProcessState();

  @override
  List<Object> get props => [];
}

class ProcessInitial extends ProcessState {}

class ObtainPointsDataLoading extends ProcessState {}

class ObtainPointsDataLoaded extends ProcessState {
  final List<PathFindingRequest> data;

  const ObtainPointsDataLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class ObtainPointsDataError extends ProcessState {
  final String message;

  const ObtainPointsDataError(this.message);

  @override
  List<Object> get props => [message];
}

class ProcessProgress extends ProcessState {
  final int completed;
  final int total;
  final List<ShortestPathResult> path;
  final String? error;
  final bool sendingToServer;
  final bool sentToServer;

  const ProcessProgress({
    required this.completed,
    required this.total,
    required this.path,
    this.error,
    this.sendingToServer = false,
    this.sentToServer = false,
  });

  @override
  List<Object> get props => [
        completed,
        total,
        path,
        sendingToServer,
        sentToServer,
      ];

  ProcessProgress copyWith({
    int? completed,
    int? total,
    List<ShortestPathResult>? path,
    String? error,
    bool? sendingToServer,
    bool? sentToServer,
  }) {
    return ProcessProgress(
      completed: completed ?? this.completed,
      total: total ?? this.total,
      path: path ?? this.path,
      error: error ?? this.error,
      sendingToServer: sendingToServer ?? this.sendingToServer,
      sentToServer: sentToServer ?? this.sentToServer,
    );
  }
}

class SendDataLoading extends ProcessState {}

class SendDataSuccess extends ProcessState {
  final List<ShortestPathResult> path;

  const SendDataSuccess(this.path);

  @override
  List<Object> get props => [path];
}

class SendDataError extends ProcessState {
  final String message;
  final List<ShortestPathResult> path;

  const SendDataError(this.message, this.path);

  @override
  List<Object> get props => [message, path];
}
