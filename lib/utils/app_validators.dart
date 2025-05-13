class AppValidators {
  // Private constructor
  AppValidators._();

  // Singleton instance
  static final AppValidators instance = AppValidators._();

  String? validateName(String? value) {
    if (value == null || value.isEmpty) return 'Full name is required';
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty || !value.contains('@')) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateRepeatPassword(String? value, String? originalPassword) {
    if (value == null || originalPassword == null) {
      return 'Password confirmation is required';
    }
    if (value != originalPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

}
