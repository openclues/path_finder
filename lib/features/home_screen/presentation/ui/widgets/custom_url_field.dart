import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common/validators.dart';
import '../../cubit/obtain_points_data_cubit.dart';

class CustomUrlTextField extends StatelessWidget {
  const CustomUrlTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (v) {
        context.read<ObtainPointsDataCubit>().getData(v);
      },
      validator: Validators.validateUrl,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.link),
        hintText: 'Enter URL',
      ),
    );
  }
}
