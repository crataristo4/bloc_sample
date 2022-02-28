/// File: intents.dart
/// Project: mobile
/// Created Date: Wednesday, May 26th 2021, 6:30:39 pm
/// Author: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Last Modified: Wednesday, May 26th 2021 6:35:45 pm
/// Modified By: Dennis Bilson <codelbas.quabynah@gmail.com>
/// -----
/// Copyright (c) 2021 Quabynah Codelabs LLC
import 'package:shared_utils/shared_utils.dart';
import 'package:url_launcher/url_launcher.dart';

/// open [url] from default browser
void openUrl(String url) async {
  try {
    await launch(url, enableJavaScript: true);
  } catch (e) {
    logger.e(e);
    await launch(url, forceWebView: true, enableJavaScript: true);
  }
}
