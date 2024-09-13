import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../results/presentation/results_screen.dart';
import '../../cubit/process_cubit.dart';
import '../../cubit/process_state.dart';

class SendResultsToServerButton extends StatelessWidget {
  const SendResultsToServerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProcessCubit, ProcessState>(
      builder: (context, state) {
        if (shouldShowButton(state)) {
          return _buildButton(context, state);
        }
        return const SizedBox.shrink();
      },
    );
  }

  bool shouldShowButton(ProcessState state) {
    return (state is ProcessProgress && state.completed == state.total) ||
        state is SendDataError ||
        state is SendDataSuccess ||
        state is SendDataLoading;
  }

  Widget _buildButton(BuildContext context, ProcessState state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _getButtonColor(state),
        ),
        onPressed: () => _onButtonPressed(context, state),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _getButtonChild(state),
        ),
      ),
    );
  }

  Color _getButtonColor(ProcessState state) {
    return state is SendDataLoading ? Colors.grey : Colors.blue;
  }

  Widget _getButtonChild(ProcessState state) {
    if (state is SendDataSuccess) {
      return const Text(
        'Show Results',
        style: TextStyle(fontSize: 16.0, color: Colors.black),
      );
    } else {
      return const Text(
        'Send Results',
        style: TextStyle(fontSize: 16.0, color: Colors.black),
      );
    }
  }

  void _onButtonPressed(BuildContext context, ProcessState state) async {
    if (state is SendDataSuccess) {
      Navigator.pushNamed(context, ResultsScreen.routeName,
          arguments: state.path);
    } else if (state is! SendDataLoading) {
      context.read<ProcessCubit>().sendDataToServer();
    }
  }
}
