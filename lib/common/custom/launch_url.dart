import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchInBrowser(String url) async {
  final uri = Uri.parse(url);
  await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  ).catchError((err) {
    if (kDebugMode) {
      print("$err");
    }
  });
}
