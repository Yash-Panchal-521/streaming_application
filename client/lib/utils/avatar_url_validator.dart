String? validateAvatarUrl(String? avatarUrl) {
  if (avatarUrl == null || avatarUrl.isEmpty || !Uri.parse(avatarUrl).isAbsolute) {
    return 'Please enter a valid URL';
  }
  return null;
}
