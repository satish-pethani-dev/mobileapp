import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfigStore extends ChangeNotifier {
  String _apiBaseUrl = '';

  String get apiBaseUrl => _normalized(_apiBaseUrl);

  bool get isConfigured => _apiBaseUrl.isNotEmpty;

  bool get isLocalhost =>
      apiBaseUrl.contains('localhost') || apiBaseUrl.contains('127.0.0.1');

  Future<void> load() async {
    final fromEnv = dotenv.env['API_BASE_URL']?.trim();

    if (fromEnv == null || fromEnv.isEmpty) {
      _apiBaseUrl = '';
    } else {
      _apiBaseUrl = _normalized(fromEnv);
    }

    notifyListeners();
  }

  String _normalized(String value) {
    return value.trim().replaceAll(RegExp(r'/$'), '');
  }

  String friendlyConnectionError(Object error) {
    if (!isConfigured) {
      return 'API_BASE_URL is not set. Copy mobile/.env.example to mobile/.env '
          'and set your backend URL (same Cloudflare tunnel as shopify-app).';
    }

    if (isLocalhost) {
      return 'Cannot reach $apiBaseUrl from this device. '
          'For USB Android use adb reverse and http://127.0.0.1:4000 in .env. '
          'For physical device over Wi‑Fi use your Cloudflare tunnel URL in .env.';
    }

    return 'Cannot reach backend at $apiBaseUrl. '
        'Check mobile/.env API_BASE_URL matches your running backend/tunnel.';
  }
}
