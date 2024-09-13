import 'package:flutter/material.dart';
import 'package:path_finder/core/constants/strings/app_strings.dart';
import 'package:path_finder/features/processing/presentation/ui/screens/visualize_the_grid.dart';

import '../../processing/data/models/shortest_path_result.dart';

class ResultsScreen extends StatelessWidget {
  final List<ShortestPathResult> shortestPathResults;

  static const String routeName = '/results';
  const ResultsScreen({super.key, required this.shortestPathResults});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.results),
        ),
        body: ListView.separated(
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(PreviewScreen.routeName,
                      arguments: shortestPathResults[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    shortestPathResults[index].path,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: shortestPathResults.length));
  }
}
