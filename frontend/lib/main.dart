import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat/app/app.dart';
import 'package:void_chat/app/app_providers.dart';
import 'package:void_chat/core/di/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(
    MultiBlocProvider(
      providers: AppProviders.providers,
      child: const VoidChat(),
    ),
  );
}
 