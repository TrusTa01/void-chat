import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> launchMyUrl(String urlString) async {
  if (urlString.isEmpty) return false;
  try {
    final Uri url = Uri.parse(urlString);
    return await launchUrl(url, mode: LaunchMode.externalApplication);
  } on FormatException catch (e) {
    debugPrint('launchMyUrl: неверный URL "$urlString": $e');
    return false;
  } catch (e, stack) {
    debugPrint('launchMyUrl: $e');
    debugPrint(stack.toString());
    return false;
  }
}
