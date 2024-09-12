import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_finder/core/common/validators.dart';
import 'package:path_finder/core/constants/strings/app_strings.dart';
import 'package:path_finder/features/home_screen/presentation/cubit/obtain_points_data_cubit.dart';

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
    return BlocBuilder<ObtainPointsDataCubit, ObtainPointsDataState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            width: double.infinity,
            child: ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.blue[300]),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(AppStrings.startCountingProcess,
                    style:
                        const TextStyle(fontSize: 16.0, color: Colors.black)),
              ),
            ),
          ),
          appBar: AppBar(
            title: const Text('Home Screen'),
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
                  TextFormField(
                    onSaved: (v) {
                      context.read<ObtainPointsDataCubit>().getData(v);
                    },
                    validator: Validators.validateUrl,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.link),
                      hintText: 'Enter URL',
                    ),
                  ),
                  if (state is ObtainPointsDataLoading)
                    const Center(child: CircularProgressIndicator()),
                  if (state is ObtainPointsDataError)
                    Center(
                      child: Text(
                        state.failure.message,
                        style: const TextStyle(color: Colors.red),
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
