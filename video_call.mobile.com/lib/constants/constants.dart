class UserInfo {
  String id = '';
  String name = '';

  UserInfo({
    required this.id,
    required this.name,
  });

  // UserInfo({ required this.id, required this.name, });: This is a named constructor that requires both id and name to be provided when creating an instance of UserInfo.

  bool get isEmpty => id.isEmpty;

  UserInfo.empty();
}

// This is a named constructor that creates an empty UserInfo instance. It doesn't initialize any properties, so id and name remain as empty strings.

UserInfo currentUser = UserInfo.empty();
const String cacheUserIDKey = 'cache_user_id_key';
const String appName = 'Flutter Video Calls';
const String appLogoAsset = 'assets/logo.jpg';
