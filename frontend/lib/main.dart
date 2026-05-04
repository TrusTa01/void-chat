import 'package:flutter/material.dart';
import 'package:void_chat/app/app.dart';
import 'package:void_chat/core/di/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const VoidChat());
}
