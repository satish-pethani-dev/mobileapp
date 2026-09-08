import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/api/mobile_api_client.dart';
import 'core/config/app_config_store.dart';
import 'core/theme/color_utils.dart';
import 'features/preview/preview_controller.dart';
import 'features/preview/preview_home_screen.dart';
import 'features/qr_scanner/qr_scanner_screen.dart';

class MobilePreviewApp extends StatelessWidget {
  const MobilePreviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppConfigStore()..load(),
        ),
        ProxyProvider<AppConfigStore, MobileApiClient>(
          update: (_, configStore, __) => MobileApiClient(configStore),
        ),
        ChangeNotifierProxyProvider<MobileApiClient, PreviewController>(
          create: (context) => PreviewController(context.read<MobileApiClient>()),
          update: (_, apiClient, controller) =>
              controller ?? PreviewController(apiClient),
        ),
      ],
      child: Consumer<PreviewController>(
        builder: (context, preview, _) {
          final seedColor = preview.config != null
              ? parseHexColor(preview.config!.appSettings.primaryColor)
              : parseHexColor('#008060');

          return MaterialApp(
            title: preview.config?.appSettings.appName ?? 'Shopify Preview App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: seedColor,
              ),
              scaffoldBackgroundColor: Colors.white,
              useMaterial3: true,
            ),
            home: const _AppRoot(),
          );
        },
      ),
    );
  }
}

class _AppRoot extends StatelessWidget {
  const _AppRoot();

  @override
  Widget build(BuildContext context) {
    final preview = context.watch<PreviewController>();

    if (preview.isLoading && preview.config == null) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (preview.config != null) {
      return const PreviewHomeScreen();
    }

    return const _LandingScreen();
  }
}

class _LandingScreen extends StatelessWidget {
  const _LandingScreen();

  @override
  Widget build(BuildContext context) {
    final config = context.watch<AppConfigStore>();
    final apiUrl = config.apiBaseUrl;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Icon(
                Icons.phone_iphone,
                size: 72,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text(
                'Shopify Mobile Preview',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),
              const Text(
                'Scan the QR code from App Builder to preview your store on this device.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              if (!config.isConfigured)
                Card(
                  color: Theme.of(context).colorScheme.errorContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Missing API_BASE_URL.\n'
                      'Set it in mobile/.env (see .env.example), then restart the app.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                    ),
                  ),
                )
              else
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Backend URL',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(height: 6),
                        SelectableText(
                          apiUrl,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Configured in mobile/.env',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).hintColor,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              const Spacer(),
              FilledButton.icon(
                onPressed: config.isConfigured
                    ? () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => const QrScannerScreen(),
                          ),
                        );
                      }
                    : null,
                icon: const Icon(Icons.qr_code_scanner),
                label: const Text('Scan preview QR'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
