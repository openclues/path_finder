import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_finder/features/home_screen/presentation/cubit/home_scree_cubit.dart';

import '../../../../../core/common/validators.dart';

class CustomUrlTextField extends StatelessWidget {
  const CustomUrlTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (v) {
        context.read<HomeScreeCubit>().saveUrlForProcessing(v!);
      },
      validator: Validators.validateUrl,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.link),
        hintText: 'Enter URL',
      ),
    );
  }
}
