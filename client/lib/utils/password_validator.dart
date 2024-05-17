String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter your password';
  }

  // Check if password contains at least one uppercase letter
  if (!value.contains(RegExp(r'[A-Z]'))) {
    return 'Password must contain at least one uppercase letter';
  }

  // Check if password contains at least one lowercase letter
  if (!value.contains(RegExp(r'[a-z]'))) {
    return 'Password must contain at least one lowercase letter';
  }

  // Check if password contains at least one digit
  if (!value.contains(RegExp(r'[0-9]'))) {
    return 'Password must contain at least one digit';
  }

  // Check if password contains at least one special character
  if (!value.contains(RegExp(r'[!@#\$&*~]'))) {
    return 'Password must contain at least one special character';
  }

  // Check if password length is at least 6 characters
  if (value.length < 6) {
    return 'Password must be at least 6 characters long';
  }

  // Password meets all criteria
  return null;
}
