String? validateDescription(String? value) {
  if (value == null || value.isEmpty) {
    return "Description cannot be empty";
  }
  return null;
}
