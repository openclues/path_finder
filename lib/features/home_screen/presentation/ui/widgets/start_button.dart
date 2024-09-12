import 'package:flutter/material.dart';
import 'package:path_finder/core/constants/strings/app_strings.dart';

class StartButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const StartButton({
    super.key,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
