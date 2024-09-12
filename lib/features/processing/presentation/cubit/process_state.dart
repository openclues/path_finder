part of 'process_cubit.dart';

final class ProcessProgress extends Equatable {
  final int? completed;
  final int? total;
  final List<ShortestPathResult>? path;
  final String? error;
  final bool? sendingToServer;

  const ProcessProgress(
      {this.completed = 0,
      this.total = 0,
      this.path = const [],
      this.error,
      this.sendingToServer = false});

  @override
  List<Object> get props => [completed!, total!, path!, sendingToServer!];

  //copyWith method
  ProcessProgress copyWith({
    final int? completed,
    final int? total,
    final List<ShortestPathResult>? path,
    final String? error,
    final bool? sendingToServer,
  }) {
    return ProcessProgress(
      completed: completed ?? this.completed,
      path: path ?? this.path,
      total: total ?? this.total,
    );
  }
}
