import 'package:flutter/material.dart';

/// Fired when the user taps the already-selected bottom-nav tab.
class ShellTabReselectNotifier extends ChangeNotifier {
  int? lastIndex;

  void onReselect(int index) {
    lastIndex = index;
    notifyListeners();
  }
}

class ShellTabReselectScope extends InheritedWidget {
  const ShellTabReselectScope({
    super.key,
    required this.notifier,
    required super.child,
  });

  final ShellTabReselectNotifier notifier;

  static ShellTabReselectNotifier? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ShellTabReselectScope>()
        ?.notifier;
  }

  @override
  bool updateShouldNotify(ShellTabReselectScope old) => notifier != old.notifier;
}
