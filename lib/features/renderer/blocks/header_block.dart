import 'package:flutter/material.dart';

import '../../../core/models/mobile_models.dart';

class HeaderBlock extends StatelessWidget {
  const HeaderBlock({
    super.key,
    required this.block,
    required this.primaryColor,
  });

  final BuilderBlock block;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      color: primaryColor,
      child: Row(
        children: [
          Expanded(
            child: Text(
              block.title ?? 'Welcome',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (block.style['showCart'] == true)
            const Icon(Icons.shopping_cart_outlined, color: Colors.white),
        ],
      ),
    );
  }
}
