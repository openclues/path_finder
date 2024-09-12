import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path_finder/features/home_screen/data/models/position_model.dart';

part 'process_state.dart';

class ProcessCubit extends Cubit<ProcessState> {
  ProcessCubit() : super(ProcessInitial());

  Future<void> findShortestPathBetweenPoints() async {}
}
