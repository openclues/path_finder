import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/strings/app_strings.dart';
import '../../../../processing/presentation/ui/screens/visualize_the_grid.dart';
import '../../cubit/obtain_points_data_cubit.dart';
import '../widgets/custom_url_field.dart';
import '../widgets/start_button.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ObtainPointsDataCubit, ObtainPointsDataState>(
      listener: (context, state) {
        if (state is ObtainPointsDataLoaded) {
          Navigator.of(context).pushNamed(VisualizeTheGrid.routeName,
              arguments: state.gridPoints.first);
        }
      },
      builder: (context, state) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: state is ObtainPointsDataLoading
              ? const CircularProgressIndicator()
              : StartButton(
                  formKey: _formKey,
                ),
          appBar: AppBar(
            title: Text(AppStrings.homeScreen),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.setAvalidUrlLinkToCotinue),
                  const SizedBox(height: 16.0),
                  const CustomUrlTextField(),
                  if (state is ObtainPointsDataError)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Center(
                        child: Text(
                          state.failure.message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
