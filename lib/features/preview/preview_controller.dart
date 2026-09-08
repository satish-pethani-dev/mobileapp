import 'package:flutter/foundation.dart';

import '../../core/api/mobile_api_client.dart';
import '../../core/models/mobile_models.dart';

class PreviewController extends ChangeNotifier {
  PreviewController(this._apiClient);

  final MobileApiClient _apiClient;

  PreviewConfig? config;
  bool isLoading = false;
  String? errorMessage;

  Future<void> loadFromToken(String token) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      config = await _apiClient.loadPreviewConfig(token);
    } catch (error) {
      errorMessage = error.toString().replaceFirst('Exception: ', '');
      config = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clear() {
    config = null;
    errorMessage = null;
    notifyListeners();
  }
}
