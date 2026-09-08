import 'app_config_store.dart';

/// Legacy accessor — prefer [AppConfigStore] via Provider.
class AppConfig {
  static AppConfigStore? _store;

  static void bind(AppConfigStore store) {
    _store = store;
  }

  static String get apiBaseUrl =>
      _store?.apiBaseUrl ?? 'http://localhost:4000';
}
