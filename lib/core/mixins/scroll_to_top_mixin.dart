import 'package:flutter/material.dart';

mixin ScrollToTopMixin<T extends StatefulWidget> on State<T> {
  late final ScrollController scrollToTopController;

  void initScrollToTop() {
    scrollToTopController = ScrollController();
  }

  void disposeScrollToTop() => scrollToTopController.dispose();

  void scrollToTop({bool animated = true}) {
    if (!scrollToTopController.hasClients) return;
    if (animated) {
      scrollToTopController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      scrollToTopController.jumpTo(0);
    }
  }
}
