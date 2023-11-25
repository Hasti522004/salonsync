class UserManager {
  static String? _userId;

  static String? get userId => _userId;

  static setUserId(String? userId) {
    _userId = userId;
  }
}
