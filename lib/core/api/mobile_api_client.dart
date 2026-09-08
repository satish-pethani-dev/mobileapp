import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/app_config_store.dart';
import '../models/mobile_models.dart';

class MobileApiClient {
  MobileApiClient(this._configStore, {http.Client? client})
      : _client = client ?? http.Client();

  final AppConfigStore _configStore;
  final http.Client _client;

  Future<PreviewConfig> loadPreviewConfig(String token) async {
    final url = '${_configStore.apiBaseUrl}/api/mobile/preview/$token';

    try {
      final response = await _client.get(Uri.parse(url));

      if (response.statusCode != 200) {
        throw Exception('Backend returned ${response.statusCode}');
      }

      return PreviewConfig.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    } catch (error) {
      throw Exception(_configStore.friendlyConnectionError(error));
    }
  }

  Future<bool> testConnection() async {
    final response = await _client
        .get(Uri.parse('${_configStore.apiBaseUrl}/health'))
        .timeout(const Duration(seconds: 5));
    return response.statusCode == 200;
  }
}
