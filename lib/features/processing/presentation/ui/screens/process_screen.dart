import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_finder/features/processing/presentation/cubit/process_cubit.dart';

class ProcessScreen extends StatelessWidget {
  static const String routeName = '/process';
  const ProcessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Processing'),
      ),
      body: BlocBuilder<ProcessCubit, ProcessState>(
        builder: (context, state) {
          if (state is ProcessInitial) {
            context.read<ProcessCubit>().findShortestPathBetweenPoints();
            return const Center(
              child: Text('Initial'),
            );
          } else if (state is ProcessLoaded) {
            return Center(
              child: Text('Path: ${state.path}'),
            );
          } else if (state is ProcessLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return const Center(
            child: Text('Processing...'),
          );
        },
      ),
    );
  }
}
