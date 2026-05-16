import 'package:flutter/material.dart';
import 'package:ppu_connect/core/constants/app_constants.dart';

class UserAvatar extends StatefulWidget {
  const UserAvatar({
    super.key,
    required this.name,
    this.avatarUrl,
    this.radius = 24,
  });

  final String name;
  final String? avatarUrl;
  final double radius;

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  bool _hasError = false;

  static const _fallback = AssetImage(AppImages.profile);

  @override
  void didUpdateWidget(UserAvatar old) {
    super.didUpdateWidget(old);
    if (old.avatarUrl != widget.avatarUrl) {
      _hasError = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final url = widget.avatarUrl;
    final useNetwork = url != null && url.isNotEmpty && !_hasError;

    return CircleAvatar(
      radius: widget.radius,
      backgroundImage: useNetwork ? NetworkImage(url) : _fallback,
      onBackgroundImageError: useNetwork
          ? (_, __) {
              if (mounted) setState(() => _hasError = true);
            }
          : null,
    );
  }
}
