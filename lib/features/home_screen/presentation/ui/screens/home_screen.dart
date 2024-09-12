import 'package:flutter/material.dart';

import '../../../../../core/constants/strings/app_strings.dart';
import '../widgets/custom_url_field.dart';
import '../widgets/start_button.dart';

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
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: StartButton(
        formKey: _formKey,
      ),
      appBar: AppBar(
        title: Text(AppStrings.homeScreen),
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
              const CustomUrlTextField(),
            ],
          ),
        ),
      ),
    );
  }
}
