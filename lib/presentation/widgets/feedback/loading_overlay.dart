import 'package:flutter/material.dart';
import 'package:ppu_connect/presentation/widgets/feedback/loading_indicator.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    super.key,
    required this.loading,
    required this.child,
  });

  final bool loading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (loading)
          const Positioned.fill(
            child: ColoredBox(
              color: Colors.black26,
              child: LoadingIndicator(),
            ),
          ),
      ],
    );
  }
}
