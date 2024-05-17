class Api {
  static String baseURL = "http://localhost:5002/api";

  static String authURL = "$baseURL/auth";
  static String loginURL = "$authURL/login";
  static String registerURL = "$authURL/register";

  static String channelsURL = "$baseURL/channels";
  static String followedChannelURL = "$channelsURL/followed";
  static String followChannelURL = "$channelsURL/follow";

  static String settingsURL = "$baseURL/settings";
  static String channelSettingsURL = "$settingsURL/channel";
  static String passwordSettingsURL = "$settingsURL/password";
}
