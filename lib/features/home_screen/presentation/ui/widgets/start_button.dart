import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_finder/core/constants/strings/app_strings.dart';
import 'package:path_finder/features/home_screen/presentation/cubit/home_scree_cubit.dart';
import 'package:path_finder/features/processing/presentation/ui/screens/process_screen.dart';

class StartButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const StartButton({
    super.key,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeScreeCubit, HomeScreeState>(
      listener: (context, state) {
        if (state is HomeScreenProcessDone) {
          Navigator.of(context).pushNamed(
            ProcessScreen.routeName,
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[300]),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              AppStrings.startCountingProcess,
              style: const TextStyle(fontSize: 16.0, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
