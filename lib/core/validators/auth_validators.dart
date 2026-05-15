abstract final class EmailValidator {
  static final _emailRe = RegExp(
    r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$',
  );

  static String? ppu(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email is required';
    if (!_emailRe.hasMatch(v)) return 'Enter a valid email address';
    final lower = v.toLowerCase();
    if (!lower.endsWith('@ppu.edu.ps') &&
        !lower.endsWith('@student.ppu.edu.ps')) {
      return 'Must use a PPU email (@ppu.edu.ps or @student.ppu.edu.ps)';
    }
    return null;
  }

  static String? format(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email is required';
    if (!_emailRe.hasMatch(v)) return 'Enter a valid email address';
    return null;
  }
}

abstract final class PasswordValidator {
  static String? strength(String? v) {
    if (v == null || v.isEmpty) return 'Password is required';
    if (v.length < 8) return 'At least 8 characters';
    if (!v.contains(RegExp(r'[A-Z]'))) return 'Add an uppercase letter';
    if (!v.contains(RegExp(r'[0-9]'))) return 'Add a number';
    if (!v.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) {
      return 'Add a special character';
    }
    return null;
  }

  static String? Function(String?) match(String other) =>
      (String? v) => v != other ? 'Passwords do not match' : null;

  static int score(String v) {
    if (v.isEmpty) return 0;
    var s = 0;
    if (v.length >= 8) s++;
    if (v.contains(RegExp(r'[A-Z]'))) s++;
    if (v.contains(RegExp(r'[0-9]'))) s++;
    if (v.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) s++;
    return s; // 0–4
  }
}

abstract final class NameValidator {
  static String? required(String? v) {
    if (v == null || v.trim().isEmpty) return 'Name is required';
    if (v.trim().length > 100) return 'Name must be 100 characters or fewer';
    if (v != v.trim()) return 'Remove leading/trailing spaces';
    return null;
  }
}
