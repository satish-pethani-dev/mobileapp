import 'package:flutter/material.dart';

import '../../../core/models/mobile_models.dart';

class SearchBarBlock extends StatelessWidget {
  const SearchBarBlock({super.key, required this.block});

  final BuilderBlock block;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: block.placeholder ?? 'Search products',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              block.style['rounded'] == true ? 24 : 8,
            ),
          ),
        ),
      ),
    );
  }
}
