import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_finder/core/constants/strings/app_strings.dart';
import 'package:path_finder/features/processing/presentation/cubit/process_cubit.dart';
import 'package:path_finder/features/results/presentation/results_screen.dart';

import '../../cubit/process_state.dart';
import '../widgets/processing_main_widget.dart';
import '../widgets/send_results_button.dart';

class ProcessScreen extends StatelessWidget {
  static const String routeName = '/process';

  const ProcessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const SendResultsToServerButton(),
      appBar: AppBar(
        title: Text(AppStrings.processScreen),
      ),
      body: BlocConsumer<ProcessCubit, ProcessState>(
        listener: _processCubitListener,
        builder: (context, state) {
          if (state is ObtainPointsDataError) {
            return _buildErrorWidget(state.message);
          } else {
            return const ProcessingStateMainWidget();
          }
        },
      ),
    );
  }

  void _processCubitListener(BuildContext context, ProcessState state) {
    if (state is ObtainPointsDataError) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            state.message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    } else if (state is SendDataError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            state.message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    } else if (state is SendDataSuccess) {
      Navigator.pushNamed(
        context,
        ResultsScreen.routeName,
        arguments: state.path,
      );
    }
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(color: Colors.red, fontSize: 16),
      ),
    );
  }
}
