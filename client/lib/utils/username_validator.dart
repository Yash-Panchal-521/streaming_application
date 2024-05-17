String? validateUsername(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter your username';
  }
  if (value.length <= 3 || value.length >= 8) {
    return 'Username must be between 4 and 7 characters long';
  } else {
    return null;
  }
}
