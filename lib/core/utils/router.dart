import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_finder/features/home_screen/presentation/cubit/home_scree_cubit.dart';
import 'package:path_finder/features/home_screen/presentation/ui/screens/home_screen.dart';
import 'package:path_finder/features/processing/presentation/cubit/obtain_points_data_cubit.dart';
import 'package:path_finder/features/processing/presentation/cubit/process_cubit.dart';
import 'package:path_finder/features/processing/presentation/ui/screens/process_screen.dart';
import 'package:path_finder/service_locator.dart';

import '../../features/home_screen/data/models/path_finding_request.dart';
import '../../features/processing/data/models/shortest_path_result.dart';
import '../../features/processing/presentation/ui/screens/visualize_the_grid.dart';
import '../../features/results/presentation/results_screen.dart';

Route<dynamic> generateRouter(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
          builder: (_) => BlocProvider(
                create: (context) => HomeScreeCubit(sl()),
                child: const HomeScreen(),
              ));

    //Processing screen
    case ProcessScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => ObtainPointsDataCubit(
                      sl(),
                    ),
                  ),
                  BlocProvider(
                    create: (context) => ProcessCubit(sl(), sl()),
                  ),
                ],
                child: const ProcessScreen(),
              ));

    case ResultsScreen.routeName:
      List<ShortestPathResult> shortestPathResults =
          settings.arguments as List<ShortestPathResult>;

      return MaterialPageRoute(
          builder: (_) => ResultsScreen(
                shortestPathResults: shortestPathResults,
              ));
    case VisualizeTheGrid.routeName:
      ShortestPathResult? shortestPathResult =
          settings.arguments as ShortestPathResult?;
      return MaterialPageRoute(
          builder: (_) =>
              VisualizeTheGrid(shortestPathResult: shortestPathResult!));
    default:
      return MaterialPageRoute(builder: (_) => const Placeholder());
  }
}
