String? validateUsername(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter your username';
  }
  if (value.length <= 3 || value.length >= 31) {
    return 'Username must be between 4 and 30 characters long';
  } else {
    return null;
  }
}
