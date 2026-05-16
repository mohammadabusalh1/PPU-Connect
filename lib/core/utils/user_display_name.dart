/// Resolves a readable name when [fullName] is missing in Firestore.
String resolveUserDisplayName({
  required String fullName,
  required String email,
  String fallback = 'User',
}) {
  final trimmed = fullName.trim();
  if (trimmed.isNotEmpty) return trimmed;

  final local = email.split('@').first.trim();
  if (local.isEmpty) return fallback;

  if (local.contains('.')) {
    return local
        .split('.')
        .where((part) => part.isNotEmpty)
        .map((part) => part[0].toUpperCase() + part.substring(1).toLowerCase())
        .join(' ');
  }

  if (local.contains('_')) {
    return local
        .split('_')
        .where((part) => part.isNotEmpty)
        .map((part) => part[0].toUpperCase() + part.substring(1).toLowerCase())
        .join(' ');
  }

  return local[0].toUpperCase() + local.substring(1).toLowerCase();
}

/// Normalizes user JSON before parsing (legacy/alternate name fields).
Map<String, dynamic> normalizeUserJson(Map<String, dynamic> json) {
  final email = json['email'] as String? ?? '';
  final rawName = (json['fullName'] as String?)?.trim() ??
      (json['displayName'] as String?)?.trim() ??
      (json['name'] as String?)?.trim() ??
      '';

  return {
    ...json,
    'fullName': rawName.isNotEmpty
        ? rawName
        : resolveUserDisplayName(fullName: '', email: email),
  };
}
