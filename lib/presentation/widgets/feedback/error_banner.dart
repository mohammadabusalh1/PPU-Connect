import 'package:flutter/material.dart';

class ErrorBanner extends StatelessWidget {
  const ErrorBanner({super.key, required this.message, this.onDismiss});

  final String message;
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      child: message.isEmpty
          ? const SizedBox.shrink()
          : Material(
              color: cs.errorContainer,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: cs.onErrorContainer,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        message,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: cs.onErrorContainer,
                            ),
                      ),
                    ),
                    if (onDismiss != null)
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 18,
                          color: cs.onErrorContainer,
                        ),
                        onPressed: onDismiss,
                        visualDensity: VisualDensity.compact,
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}
