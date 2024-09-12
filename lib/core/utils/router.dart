import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_finder/features/home_screen/presentation/ui/screens/home_screen.dart';
import 'package:path_finder/features/processing/presentation/cubit/process_cubit.dart';
import 'package:path_finder/features/processing/presentation/ui/screens/process_screen.dart';
import 'package:path_finder/service_locator.dart';

import '../../features/home_screen/data/models/path_finding_request.dart';
import '../../features/home_screen/presentation/cubit/obtain_points_data_cubit.dart';
import '../../features/processing/presentation/ui/screens/visualize_the_grid.dart';

Route<dynamic> generateRouter(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
          builder: (_) => BlocProvider(
                create: (context) => ObtainPointsDataCubit(sl()),
                child: const HomeScreen(),
              ));

    //Processing screen
    case ProcessScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => BlocProvider(
                create: (context) => ProcessCubit(),
                child: const ProcessScreen(),
              ));
    case VisualizeTheGrid.routeName:
      PathFindingRequest? pathFindingRequest =
          settings.arguments as PathFindingRequest?;
      return MaterialPageRoute(
          builder: (_) =>
              VisualizeTheGrid(pathFindingRequest: pathFindingRequest!));
    default:
      return MaterialPageRoute(builder: (_) => const Placeholder());
  }
}
