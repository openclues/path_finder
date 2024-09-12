import 'package:flutter/material.dart';
import 'package:path_finder/core/services/local_storage.dart';
import 'package:path_finder/core/utils/router.dart';
import 'package:path_finder/service_locator.dart' as di;
import 'package:path_finder/features/home_screen/presentation/ui/screens/home_screen.dart';

void main() async {
  //ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.instance.init();

  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: generateRouter,
      title: 'Path Finder',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: HomeScreen.routeName,
    );
  }
}
