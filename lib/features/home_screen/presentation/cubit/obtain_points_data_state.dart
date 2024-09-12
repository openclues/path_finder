part of 'obtain_points_data_cubit.dart';

sealed class ObtainPointsDataState extends Equatable {
  const ObtainPointsDataState();

  @override
  List<Object> get props => [];
}

final class ObtainPointsDataInitial extends ObtainPointsDataState {}

final class ObtainPointsDataLoading extends ObtainPointsDataState {}

final class ObtainPointsDataLoaded extends ObtainPointsDataState {
  final List<PathFindingRequest> gridPoints;

  const ObtainPointsDataLoaded(this.gridPoints);

  @override
  List<Object> get props => [gridPoints];
}

final class ObtainPointsDataError extends ObtainPointsDataState {
  final HttpFailure failure;

  const ObtainPointsDataError(this.failure);

  @override
  List<Object> get props => [failure];
}
