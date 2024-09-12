import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_finder/features/processing/presentation/cubit/obtain_points_data_cubit.dart';
import 'package:path_finder/features/processing/presentation/cubit/process_cubit.dart';
import 'package:path_finder/features/results/presentation/results_screen.dart';

class ProcessScreen extends StatelessWidget {
  static const String routeName = '/process';

  const ProcessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const SendResultsToServerButton(),
      appBar: AppBar(
        title: const Text('Processing'),
      ),
      body: BlocListener<ObtainPointsDataCubit, ObtainPointsDataState>(
        listener: _obtainPointsDataListener,
        child: BlocBuilder<ObtainPointsDataCubit, ObtainPointsDataState>(
          builder: (context, obtainPointsState) {
            return _buildBody(context, obtainPointsState);
          },
        ),
      ),
    );
  }

  void _obtainPointsDataListener(
      BuildContext context, ObtainPointsDataState state) {
    if (state is ObtainPointsDataError) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Something went wrong. Please check the URL."),
        ),
      );
    }
  }

  Widget _buildBody(BuildContext context, ObtainPointsDataState state) {
    if (state is ObtainPointsDataInitial) {
      context.read<ObtainPointsDataCubit>().getData();
      return const GettingDataLoadingWidget();
    } else if (state is ObtainPointsDataLoaded) {
      context.read<ProcessCubit>().findShortestPath(state.pathFindingRequests);
      return BlocConsumer<ProcessCubit, ProcessProgress>(
        listener: _processCubitListener,
        builder: (context, processState) {
          return _buildProcessStateWidget(processState);
        },
      );
    } else if (state is ObtainPointsDataLoading) {
      return const GettingDataLoadingWidget();
    } else {
      return Center(child: Text(state.toString()));
    }
  }

  void _processCubitListener(BuildContext context, ProcessProgress state) {
    // Handle additional process state changes here if needed
  }

  Widget _buildProcessStateWidget(ProcessProgress state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              state.completed != state.total
                  ? 'Processing the data'
                  : 'All Calculations has finished, you can send your results to server',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center),
        ),
        const SizedBox(height: 16),
        Text(
          '${(state.completed! / state.total! * 100).toStringAsFixed(0)}%',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
        Center(
          child: SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(
              value: state.completed! / state.total!,
            ),
          ),
        ),
      ],
    );
  }
}

class SendResultsToServerButton extends StatelessWidget {
  const SendResultsToServerButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProcessCubit, ProcessProgress>(
      builder: (context, state) {
        if (state.completed != state.total || state.total == 0) {
          return const SizedBox.shrink();
        }
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[300]),
            onPressed: () async {
              final List<Map<String, dynamic>> jsonList =
                  state.path!.map((result) => result.toJson()).toList();
              Dio dio = Dio();
              Response response = await dio.post(
                'https://flutter.webspark.dev/flutter/api',
                data: jsonList,
              );
              if (response.statusCode == 200) {
                Navigator.pushNamed(context, ResultsScreen.routeName,
                    arguments: state.path);
              }
              // Send the results to the server
              // var jsoneNcoded = json.encode(jsonList);
              // var response = await http.post(
              //     Uri.parse(
              //       'https://flutter.webspark.dev/flutter/api',
              //     ),
              //     body: jsoneNcoded);

              // print(response.body);
            },
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Send Results',
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
            ),
          ),
        );
      },
    );
  }
}

class GettingDataLoadingWidget extends StatelessWidget {
  const GettingDataLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Getting the data'),
        SizedBox(height: 16),
        Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}
