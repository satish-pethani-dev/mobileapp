import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

import '../../core/models/mobile_models.dart';
import '../preview/preview_controller.dart';
class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  bool _handled = false;
  bool _loading = false;

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_handled) {
      return;
    }

    final rawValue = capture.barcodes.first.rawValue;
    if (rawValue == null) {
      return;
    }

    _handled = true;
    setState(() => _loading = true);

    try {
      final payload = PreviewPayload.fromQr(rawValue);
      await context.read<PreviewController>().loadFromToken(payload.previewToken);

      if (!mounted) {
        return;
      }

      final controller = context.read<PreviewController>();
      final error = controller.errorMessage;
      if (error != null) {
        _handled = false;
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
        return;
      }

      if (controller.config == null) {
        _handled = false;
        setState(() => _loading = false);
        return;
      }

      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (error) {
      _handled = false;
      if (!mounted) {
        return;
      }
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid QR code: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        title: const Text('Scan Preview QR'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(
            onDetect: _onDetect,
          ),
          if (_loading)
            const ColoredBox(
              color: Color(0xCC000000),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: Colors.white),
                    SizedBox(height: 16),
                    Text(
                      'Opening your store…',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
