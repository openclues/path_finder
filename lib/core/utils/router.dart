import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_finder/features/home_screen/presentation/ui/screens/home_screen.dart';
import 'package:path_finder/service_locator.dart';

import '../../features/home_screen/presentation/cubit/obtain_points_data_cubit.dart';

Route<dynamic> generateRouter(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
          builder: (_) => BlocProvider(
                create: (context) => ObtainPointsDataCubit(sl()),
                child: const HomeScreen(),
              ));
    default:
      return MaterialPageRoute(builder: (_) => const Placeholder());
  }
}
