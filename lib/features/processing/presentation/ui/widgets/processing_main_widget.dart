import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/process_cubit.dart';
import '../../cubit/process_state.dart';

class ProcessingStateMainWidget extends StatelessWidget {
  const ProcessingStateMainWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProcessCubit, ProcessState>(
      builder: (context, state) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _buildText(state),
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              _builProgressIndicator(state),
            ]);
      },
    );
  }

  _buildText(ProcessState state) {
    if (state is ObtainPointsDataLoading) {
      return 'Getting data from the server';
    } else if (state is ProcessProgress && state.completed < state.total) {
      return 'Processing the data';
    } else if (state is ProcessProgress && state.completed == state.total) {
      return 'All calculations have finished. You can now send your results to the server';
    } else if (state is SendDataSuccess) {
      return 'All calculations have finished. Results have been sent to the server';
    } else if (state is SendDataError) {
      return 'An error occurred while sending the results to the server ${state.message} ';
    } else if (state is SendDataLoading) {
      return 'Sending the results to the server';
    } else {
      return 'Processing the data';
    }
  }

  _builProgressIndicator(ProcessState state) {
    if (state is ObtainPointsDataLoading) {
      return const Column(
        children: [
          SizedBox(height: 16),
          Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      );
    } else if (state is ProcessProgress && state.completed < state.total) {
      return Column(
        children: [
          Text(
            '${(state.completed / state.total * 100).toStringAsFixed(0)}%',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                value: state.completed / state.total,
              ),
            ),
          ),
        ],
      );
    } else if (state is SendDataSuccess ||
        state is SendDataError ||
        state is ProcessProgress && state.completed == state.total) {
      return const Column(
        children: [
          Text(
            '100%',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                value: 1.0,
              ),
            ),
          ),
        ],
      );
    } else if (state is SendDataLoading) {
      return const Column(
        children: [
          Text(
            'Sending...',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
