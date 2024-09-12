part of 'process_cubit.dart';

sealed class ProcessState extends Equatable {
  const ProcessState();

  @override
  List<Object> get props => [];
}

final class ProcessInitial extends ProcessState {}

final class ProcessLoading extends ProcessState {}

final class ProcessLoaded extends ProcessState {
  final List<Position> path;

  const ProcessLoaded({required this.path});

  @override
  List<Object> get props => [path];
}
